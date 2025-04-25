# E-Commerce-DB
1. 📦 product
A table to manage products

PK: product_id
Attributes: name, brand_id, base_price .
FK: brand_id → brand(brand_id)

2. 🏷️ brand
A table to manage the brands 

PK: brand_id
Attributes: name, description, logo_url, etc.

3. 🗂️ product_category
A table that engraves the categories of all the products it has.

PK: category_id
Attributes: name, description, parent_id (if hierarchical)

4. 🔄 product_variation
Contains all of the differences pf the products respectively in all aspects.

PK: variation_id
FKs:
product_id → product(product_id)
color_id → color(color_id) (optional)
size_option_id → size_option(size_option_id) (optional)

5. 🧾 product_item

PK: product_item_id
Attributes: sku, price, stock_quantity
FKs:
variation_id → product_variation(variation_id)

6. 🎨 color
PK: color_id
Attributes: name, hex_value, image

7. 📏 size_category
PK: size_category_id
Attributes: name (e.g., "Clothing", "Shoes")

8. 📐 size_option
PK: size_option_id
FK: size_category_id → size_category(size_category_id)
Attribute: label (e.g., "M", "42")

9. 🧪 attribute_type
PK: type_id
Attributes: name (e.g., "Text", "Number", "Boolean")

10. 📚 attribute_category
PK: category_id
Attributes: name (e.g., "Physical", "Technical")

11. 🧵 product_attribute
PK: attribute_id
FKs:
product_id → product(product_id)
attribute_category_id → attribute_category(category_id)
type_id → attribute_type(type_id)
Attributes: name, value

12. 🖼️ product_image
This is the urls that exhibits the image of the products
PK: image_id
Attributes: url, alt_text
FK: product_id → product(product_id)

