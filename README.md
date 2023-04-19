# This is a personal repositories for my personal studies about some programing topics...

## data_structures lists
Was create for studies porposes based on the articles

https://medium.com/amiralles/mastering-data-structures-in-ruby-linked-lists-708347a30360 \
https://medium.com/amiralles/mastering-data-structures-in-ruby-doubly-linked-lists-e5e5aff5ff67 \
https://medium.com/amiralles/mastering-data-structures-in-ruby-circular-linked-lists-8bd35769cc5 \
https://medium.com/amiralles/stacks-are-a-special-kind-of-linked-lists-that-allow-us-to-efficiently-store-retrieve-data-in-last-9efab58fd100

# Interface

### SinglyLinked

| Method | Summary | Complexity |
| ------ | ------- |-----------|
|`#initialize`|`Initializes an Empty list`|O(1)|
|`#insert(item)`|`Inserts a new item into the list`|O(1)|
|`#remove(item)`|`Removes an item from the list`|O(n)|
|`#cat(list)`|`Catenates a list to the current list`|O(1)|
|`#clear`|`Remove all items from the list`|O(n)|
|`#find_first(&predicate)`|`Returns the first element that matches the predicate`|O(n)|
|`#each`|`loops over the list yielding one element at time.`|O(n)|
|`#print`|`Prints the contents of the list`|O(n)|

### DoubleLinked

| Method | Summary | Complexity |
| ------ | ------- |-----------|
|`#initialize`|`Initializes an Empty list`|O(1)|
|`#insert(item)`|`Inserts a new item into the list`|O(1)|
|`#remove(item)`|`Removes an item from the list`|O(1)|
|`#cat(list)`|`Catenates a list to the current list`|O(1)|
|`#clear`|`Remove all items from the list`|O(n)|
|`#find_first(&predicate)`|`Returns the first element that matches the predicate`|O(n)|
|`#each`|`loops over the list yielding one element at time.`|O(n)|
|`#print`|`Prints the contents of the list`|O(n)|
|`#find_last(&predicate)`|`Returns the last element that matches the predicate`|O(n)|
|`#reverse_print`|`Loops over the list backward yielding one element at a time.`|O(n)|
|`#reverse_each`|`Prints the contents of the list backward`|O(n)|


### CircularLinked

| Method | Summary | Complexity |
| ------ | ------- |-----------|
|`#initialize`|`Initializes an Empty list`|O(1)|
|`#insert(item)`|`Inserts a new item into the list`|O(n)|
|`#insert_next(prev_node,item)`|`Inserts a new item into the list, right next to the previous node.`|O(1)|
|`#remove(item)`|`Removes an item from the list`|O(n)|
|`#remove_next(prev_node)`|`Removes the element the is next to previous node`|O(1)|
|`#clear`|`Remove all items from the list`|O(n)|
|`#find_first(&predicate)`|`Returns the first element that matches the predicate`|O(n)|
|`#move_next`|`Sets the current node to point to the next node in the list`|O(1)|
|`#full_scan`|`Traverses all elements in the list starting from the head node`|O(n)|
|`#print`|`Prints the contents of the list`|O(n)|

### Stack

| Method | Summary | Complexity |
| ------ | ------- |-----------|
|`#initialize`|`Initializes an Empty stack`|O(1)|
|`#push(item)`|`Inserts a new item into the stack`|O(1)|
|`#pop`|`Removes an item from the top of the stack`|O(1)|
|`#peek`|`Returns the item that's the top of the stack`|O(1)|
|`#clear`|`Pop all elements from the stack`|O(n)|
|`#each`|`Loops over the stack yielding one element at a time`|O(n)|
|`#print`|`Prints the contents of the stack`|O(n)|
