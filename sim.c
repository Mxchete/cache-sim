#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// this can be turned on if you want to see more information about what the
// final output of the cache is
// #define MORE_PRINTS

// if you want to see how fast the program executes
// #define TRACK_TIME

#ifdef TRACK_TIME
#include <time.h>
#endif

// given as const for this assignment
const uint8_t BLOCK_SZ = 64;

uint64_t CACHE_SZ;
uint64_t ASSOC;
bool WB;
bool REPLACEMENT;
char *TRACE_FILE_PATH;

uint64_t NUM_SETS;

double num_hit = 0;
double num_miss = 0;
uint64_t num_writes = 0;
uint64_t num_reads = 0;
double total = 0;

struct array_item {
  uint64_t tag;
  uint64_t lru_pos;
  bool dirty;
};

struct array_item *array;

void init_array() {
  array = calloc(NUM_SETS * ASSOC, sizeof(struct array_item));
}

void free_array() { free(array); }

void clean_cache_item(struct array_item *item) {
  item->tag = 0;
  item->lru_pos = 0;
  item->dirty = 0;
}

uint32_t get_set(uint64_t add) { return ((add / BLOCK_SZ) % NUM_SETS) * ASSOC; }
uint64_t get_tag(uint64_t add) { return (add / BLOCK_SZ); }

void update_lru(uint64_t add) {
  uint32_t set = get_set(add);
  uint64_t tag = get_tag(add);
  for (int i = 0; i < ASSOC; i++) {
    if (tag == ((set + i)[array]).tag) {
      ((set + i)[array]).lru_pos = 1;
    } else if (((set + i)[array]).lru_pos != 0) {
      ((set + i)[array]).lru_pos += 1;
    }
  }
}

struct array_item *add_to_cache(uint64_t add) {
  uint32_t set = get_set(add);
  uint64_t tag = get_tag(add);
  // hold array item to be evicted
  uint64_t longest = 0;
  struct array_item *replacement_candidate =
      calloc(1, sizeof(struct array_item));
  for (int i = 0; i < ASSOC; i++) {
    if (((set + i)[array]).lru_pos == 0) {
      replacement_candidate = &((set + i)[array]);
      break;
    } else if (((set + i)[array]).lru_pos >= longest) {
      longest = ((set + i)[array]).lru_pos;
      replacement_candidate = &((set + i)[array]);
    }
    // increment position of all elements after checking them
    // if pos is 0, no cache block at location
    if (longest > 0) {
      ((set + i)[array]).lru_pos += 1;
    }
  }
  if (WB && replacement_candidate->dirty) {
    num_writes += 1;
  }
  clean_cache_item(replacement_candidate);
  replacement_candidate->tag = tag;
  replacement_candidate->lru_pos = 1;
  return replacement_candidate;
}

void simulate_access(char op, uint64_t add) {
  uint32_t set = get_set(add);
  uint64_t tag = get_tag(add);
  bool hit_found = 0;
  struct array_item *location_ptr = calloc(1, sizeof(struct array_item));
#ifdef MORE_PRINTS
  printf("%ld (set %d): ", add, set / 8);
#endif

  // iterate through set
  for (int i = 0; i < ASSOC; i++) {
    hit_found |= (tag == ((set + i)[array]).tag);
    if (hit_found) {
      location_ptr = &((set + i)[array]);
      break;
    }
  }
  if (hit_found) {
#ifdef MORE_PRINTS
    printf("hit\n");
#endif
    num_hit += 1;
    // Choose policy ( LRU or FIFO ) based on the configuration
    if (!REPLACEMENT) {
      update_lru(add);
    }
  } else {
    // Cache miss scenario
#ifdef MORE_PRINTS
    printf("miss (tag %ld)\n", tag);
#endif
    num_miss += 1;
    num_reads += 1;
    location_ptr = add_to_cache(add);
  }
  if (op == 'W') {
    if (!WB) {
      num_writes += 1;
    } else {
      location_ptr->dirty = 1;
    }
  }
}

int main(int argc, char **argv) {
#ifdef TRACK_TIME
  clock_t begin = clock();
#endif
  char op;
  char *p;
  uint64_t add;
  switch (argc) {
  case 6:
    CACHE_SZ = atoi(1 [argv]);
    ASSOC = atoi(2 [argv]);
    REPLACEMENT = atoi(3 [argv]);
    WB = atoi(4 [argv]);
    NUM_SETS = CACHE_SZ / (ASSOC * BLOCK_SZ);
    FILE *file = fopen(5 [argv], "r");
    if (!file) {
      printf(" Error : Could not open the trace file.\n");
      return 1;
    }
    if (NUM_SETS <= 0) {
      printf(" Error : Invalid number of sets (%ld).\n", NUM_SETS);
      return 1;
    }
    init_array();
    // Read until end of file
    while (!feof(file)) {
      // Read operation and address
      fscanf(file, "%c %lx\n", &op, &add);

      // Begin the simulation for each address read
      simulate_access(op, add);
      total += 1;
    }

    double miss_ratio = num_miss / total;
    printf("Miss ratio %.6f\n", miss_ratio);
    printf("write %ld\n", num_writes);
    printf("read %ld\n", num_reads);
#ifdef MORE_PRINTS
    printf("Hits : %.0f\n", num_hit);
    printf("Misses : %.0f\n", num_miss);
    printf("Total %.0f\n", total);
#endif

    free_array();
    break;

  case 2:
    if (strcmp(1 [argv], "-h") == 0) {
      printf("Program usage guidelines:\n./sim <CACHE_SIZE> <ASSOC> "
             "<REPLACEMENT> <WB> <TRACE_FILE>\nWhere:\n<CACHE_SIZE> is the "
             "size of the simulated cache in bytes,\n<ASSOC> is the "
             "associativity,\n<REPLACEMENT> is the replacement policy: 0 means "
             "LRU and 1 means FIFO,\n<WB> is the Write-back policy: 0 means "
             "write-through and 1 means write-back and\n<TRACE_FILE> denotes "
             "trace file name with full path.\n");
      break;
    }

  default:
    printf("Invalid arguments supplied, the program takes 5 input arguments, "
           "use ./sim -h for argument requirements.\n");
  }
#ifdef TRACK_TIME
  clock_t end = clock();
  double total_exec_time = (double)(end - begin) / CLOCKS_PER_SEC;
  printf("Total time spent executing program: %f seconds\n", total_exec_time);
#endif
  return 0;
}
