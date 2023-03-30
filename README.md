# ruby_utils
This repository was create for studies porposes based on the articles

https://medium.com/amiralles/mastering-data-structures-in-ruby-linked-lists-708347a30360 

https://medium.com/amiralles/mastering-data-structures-in-ruby-doubly-linked-lists-e5e5aff5ff67

https://medium.com/amiralles/mastering-data-structures-in-ruby-circular-linked-lists-8bd35769cc5

# Interface

## SinglyLinked

| Method | Definition |
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

## DoubleLinked

| Method | Definition |
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

