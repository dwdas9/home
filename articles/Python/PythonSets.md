---
layout: default
title: Python Sets
parent: Python
nav_order: 1
---

## Python Sets Properties

- **No Order**: There is no order in Python sets. You might input `apple`, `orange`, `banana` and get `banana`, `apple`, `orange` as output.

<img src="images\PYTHONSETSNOORDER.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 500px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>

```python
my_set = {1, 2, 3}
print(my_set)  # Output could be {1, 2, 3} or {3, 1, 2} or any permutation
```

- **No Index**: There is no index in sets, like a jail where no inmate has a badge number.

<img src="images\setsareunindexed.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 500px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>

```python
my_set = {3, 1, 2}
print(my_set[0]) # THIS IS AN ERROR
```

- **No Duplicates**: You can't have the same item twice in a set. Duplicates are removed automatically.

<img src="images\noduplicatesgood.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 500px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>

```python
my_set = {1, 2, 2, 3}
print(my_set)  # Output: {1, 2, 3}
```

- **No In-Place Replace. Add/remove instead.**: You can add/remove items, but can't change an item's value directly. Can't in-place replace items. First, remove the old one and add the new one.

<img src="images\cantinplacereplace.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 300px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>

```python
my_set = {1, 2, 3}

my_set.remove(2) # OK
my_set.add(4) # OK
my_set[0] = 5 # ERROR
```

- **No Lists/Dictionaries as Elements**: Elements in a set must be immutable. You can't use lists or dictionaries as elements because they are mutable.

<img src="images\whatpythonsetsallow.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 500px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>

```python
# Valid elements
my_set = {1, "hello", (1, 2)} # TUPLES OK

# Invalid elements
my_set = {[1, 2], {"key": "value"}} # ERROR, NO LISTS, NO DICTS
```
