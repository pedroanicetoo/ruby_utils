# This is a personal repositories for my personal studies about some programing topics...

## data_structures lists
Was create for studies porposes based on the articles

https://medium.com/amiralles/mastering-data-structures-in-ruby-linked-lists-708347a30360

https://medium.com/amiralles/mastering-data-structures-in-ruby-doubly-linked-lists-e5e5aff5ff67

https://medium.com/amiralles/mastering-data-structures-in-ruby-circular-linked-lists-8bd35769cc5

# Interface

### SinglyLinked

| Method | Complexity |
| ---  | -----------|
| `#head` | O(1) |
| `#tail` | O(1) |
| `#length` | O(1) |
| `#initialize`| O(1) |
| `#insert(item)` | O(1) |
| `#remove(item)` | O(n) |
| `#cat(list)` | O(1) |
| `#clear` | O(n) |
| `#find_first(&predicate)` | O(n) |
| `#each` | O(n) |
| `#print` | O(n) |

### DoubleLinked

| Method | Complexity |
| ---  | -----------|
| `#head` | O(1) |
| `#tail` | O(1) |
| `#length` | O(1) |
| `#initialize`| O(1) |
| `#insert(item)` | O(1) |
| `#remove(item)` | O(1) |
| `#cat(list)` | O(1) |
| `#clear` | O(n) |
| `#find_first(&predicate)` | O(n) |
| `#each` | O(n) |
| `#reverse_each` | O(n) |
| `#print` | O(n) |
| `#reverse_print` | O(n) |
| `#find_last(&predicate)` | O(n) |


### CircularLinked

| Method | Complexity |
| ---  | -----------|
| `#head` | O(1) |
| `#length` | O(1) |
| `#initialize`| O(1) |
| `#insert(item)` | O(n) |
| `#insert_next(prev_node, item)` | O(1) |
| `#remove(item)` | O(n) |
| `#remove_next(prev_node)` | O(1) |
| `#clear` | O(n) |
| `#full_scan` | O(n) |
| `#print` | O(n) |
