---
layout: default
title: MongoDB
nav_order: 11
has_children: true
---

## What is MongoDB?

MongoDB is a document database. It stores files, just like your laptop's folders. So, why call it a database? Because it manages files much better than your filesystem. You can add metadata to files, search them, index them, and more.

But MongoDB isn't as strict as a regular database. When storing your files, you don't have to worry about different field types like int, string, or type mismatch errors.

### What is a Document Database? Is MongoDB the first of its kind?

Nope, document databases have been around since the 80s. They are called content managment systems(CMS). Before MongoDB, we had products like OpenText Documentum. These were used a lot by banks and insurance companies to go paperless. They'd scan customer documents, ID cards, and forms, and store them digitally in Documentum. 

## So, What’s the Difference Between MongoDB and Documentum (CMS)?

Even though both store files, there are some key differences:

- **Documentum**: When you store a file in Documentum, you need to follow a certain structure. Every file is stored as a `dm_document` object, which has specific fields that must be filled in. For example, if you scan and store a customer's passport, it will usually have a custom field like passport number. This value must be filled, or you’ll get an error. You can make it less restrictive by having fewer fields, but the core idea is to ensure some level of structure.

- **MongoDB**: It's much more flexible. You can store any document without worrying about following a strict structure. There are no required fields or predefined formats.

### Summary

So, while both MongoDB and Documentum deal with storing documents, MongoDB is much more laid-back and flexible, perfect for various applications. Documentum, on the other hand, is structured and great for managing business documents with specific requirements.

---