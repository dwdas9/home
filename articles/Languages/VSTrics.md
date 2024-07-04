1. Replace all .png files with images\.png

!\[([^\]]*)\]\(([^\/]+\.png)\)

![$1](images\\$2)

![alt text](image.png)

2. Replace constructs like

- **Correct Answer:** B. extend is used to create a new column or modify an existing column.

With

*extend is used to create a new column or modify an existing column.*

![alt text](image-1.png)

Search: - \*\*Correct Answer:\*\* [A-Z]\. (.+)
Replace: *$1*

Quick datasets:

df = pd.read_csv("https://raw.githubusercontent.com/plotly/datasets/master/titanic.csv")
display(df)