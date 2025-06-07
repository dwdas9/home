# SharePoint 2016 MinRole

### Before 2016:

Say, you had two servers. You could install **any** service on either of them, in **any combination**. E,g,:

- **Server 1**: Web Front-End + Search + Central Administration
- **Server 2**: Indexing + Application Services

This freedom, and lack of guidance, gave a lot of flexibility. But, you had to be careful about performance issues.

### SharePoint 2016/2019:

**MinRole** is just a **best combination** of services. Now adminstrator know beforehand, what mix is best. It's not just advice, its shown as a radio  button during installation.

Also, like before, you can still install 'anything anywhere' by clicking 'Custom' MiniRole optioin. This is how the new installer shows them:

![alt text](images\image-6.png)

#### Dedicated MinRole:

- **Front-End**
- **Application**
- **Distributed Cache**
- **Search**

![dedicated_roles](images\image-10.png)
*From Microsoft Site*


#### Special MiniRole:

- **Single-Farm**: All-in-one. Before called, Standalone Install mode. Used for Dev.
- **Custom**: Anything-anywhere. The-way-you-like-it

![alt text](images\image-12.png)
*From Microsoft Site*

#### Shared MiniRoles:

- **Front-End + Distributed Cache**
- **Application +  Search**

![alt text](images\image-11.png)
*From Microsoft Site*


Long story short: MinRole is just 'best mix of SharePoint services' as per Microsoft.

---