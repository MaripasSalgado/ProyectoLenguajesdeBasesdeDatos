
-- Table: product_categories
CREATE TABLE product_categories (
  p_cat_id NUMBER(10) PRIMARY KEY,
  p_cat_title VARCHAR2(255) NOT NULL,
  p_cat_top VARCHAR2(100) NOT NULL,
  p_cat_image VARCHAR2(100) NOT NULL,
  CONSTRAINT fk_product_categories_p_cat_id FOREIGN KEY (p_cat_id) REFERENCES products(p_cat_id)
);


-- Table: categories
CREATE TABLE categories (
  cat_id NUMBER(10) PRIMARY KEY,
  cat_title VARCHAR2(100) NOT NULL,
  cat_top VARCHAR2(100) NOT NULL,
  cat_image VARCHAR2(100) NOT NULL
);


-- Table: manufacturers
CREATE TABLE manufacturers (
  manufacturer_id NUMBER(10) PRIMARY KEY,
  manufacturer_title VARCHAR2(255) NOT NULL,
  manufacturer_top VARCHAR2(100) NOT NULL,
  manufacturer_image VARCHAR2(100) NOT NULL
);



-- Table: admins
CREATE TABLE admins (
  admin_id NUMBER(10) PRIMARY KEY,
  admin_name VARCHAR2(255) NOT NULL,
  admin_email VARCHAR2(255) NOT NULL,
  admin_pass VARCHAR2(255) NOT NULL,
  admin_image VARCHAR2(255) NOT NULL,
  admin_contact VARCHAR2(255) NOT NULL,
  admin_country VARCHAR2(255) NOT NULL,
  admin_job VARCHAR2(255) NOT NULL,
  admin_about VARCHAR2(4000) NOT NULL
);


-- Table: customers
CREATE TABLE customers (
  customer_id NUMBER(10) PRIMARY KEY,
  customer_name VARCHAR2(255) NOT NULL,
  customer_email VARCHAR2(255) NOT NULL,
  customer_pass VARCHAR2(255) NOT NULL,
  customer_country VARCHAR2(255) NOT NULL,
  customer_city VARCHAR2(255) NOT NULL,
  customer_contact VARCHAR2(255) NOT NULL,
  customer_address VARCHAR2(4000) NOT NULL,
  customer_image VARCHAR2(255) NOT NULL,
  customer_ip VARCHAR2(255) NOT NULL,
  customer_confirm_code VARCHAR2(255) NOT NULL
);


-- Table: customer_orders
CREATE TABLE customer_orders (
  order_id NUMBER(10) PRIMARY KEY,
  customer_id NUMBER(10) NOT NULL,
  due_amount NUMBER(10, 2) NOT NULL,
  invoice_no NUMBER(10) NOT NULL,
  qty NUMBER(10) NOT NULL,
  size VARCHAR2(100) NOT NULL,
  order_status VARCHAR2(100) NOT NULL,
  CONSTRAINT fk_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



-- Table: wishlist
CREATE TABLE wishlist (
  wishlist_id NUMBER(10) PRIMARY KEY,
  customer_id NUMBER(10) NOT NULL,
  product_id NUMBER(10) NOT NULL,
  CONSTRAINT fk_wishlist_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_wishlist_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Table: cart
CREATE TABLE cart (
  cart_id NUMBER(10) PRIMARY KEY,
  customer_id NUMBER(10) NOT NULL,
  p_id NUMBER(10) NOT NULL,
  ip_add VARCHAR2(255) NOT NULL,
  qty NUMBER(10) NOT NULL,
  p_price NUMBER(10, 2) NOT NULL,
  size VARCHAR2(255) NOT NULL,
  CONSTRAINT fk_cart_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_cart_product_id FOREIGN KEY (p_id) REFERENCES products(product_id)
);


-- Table: pending_orders
CREATE TABLE pending_orders (
  order_id NUMBER(10) PRIMARY KEY,
  customer_id NUMBER(10) NOT NULL,
  invoice_no NUMBER(10) NOT NULL,
  product_id NUMBER(10) NOT NULL,
  qty NUMBER(10) NOT NULL,
  size VARCHAR2(255) NOT NULL,
  order_status VARCHAR2(255) NOT NULL,
  CONSTRAINT fk_pending_orders_customer_id FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_pending_orders_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Table: coupons
CREATE TABLE coupons (
  coupon_id NUMBER(10) PRIMARY KEY,
  product_id NUMBER(10) NOT NULL,
  coupon_title VARCHAR2(255) NOT NULL,
  coupon_price NUMBER(10, 2) NOT NULL,
  coupon_code VARCHAR2(255) NOT NULL,
  coupon_limit NUMBER(10) NOT NULL,
  coupon_used NUMBER(10) NOT NULL,
  CONSTRAINT fk_coupons_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Table: bundle_product_relation
CREATE TABLE bundle_product_relation (
  rel_id NUMBER(10) PRIMARY KEY,
  rel_title VARCHAR2(255) NOT NULL,
  product_id NUMBER(10) NOT NULL,
  bundle_id NUMBER(10) NOT NULL,
  CONSTRAINT fk_bundle_product_relation_product_id FOREIGN KEY (product_id) REFERENCES products(product_id),
  CONSTRAINT fk_bundle_product_relation_bundle_id FOREIGN KEY (bundle_id) REFERENCES bundle_product_relation(bundle_id)
);


-- Table: coupon_product_relation
CREATE TABLE coupon_product_relation (
  coupon_id NUMBER(10) NOT NULL,
  product_id NUMBER(10) NOT NULL,
  PRIMARY KEY (coupon_id, product_id),
  CONSTRAINT fk_coupon_product_relation_coupon_id FOREIGN KEY (coupon_id) REFERENCES coupons(coupon_id),
  CONSTRAINT fk_coupon_product_relation_product_id FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- Table: bundle_product_relation_mapping
CREATE TABLE bundle_product_relation_mapping (
  product_id NUMBER(10) NOT NULL,
  bundle_id NUMBER(10) NOT NULL,
  PRIMARY KEY (product_id, bundle_id),
  CONSTRAINT fk_bundle_product_relation_mapping_product_id FOREIGN KEY (product_id) REFERENCES products(product_id),
  CONSTRAINT fk_bundle_product_relation_mapping_bundle_id FOREIGN KEY (bundle_id) REFERENCES bundle_product_relation(bundle_id)
);


-- Table: about_us
CREATE TABLE about_us (
  about_id NUMBER(10) PRIMARY KEY,
  about_heading VARCHAR2(255) NOT NULL,
  about_short_desc VARCHAR2(4000) NOT NULL,
  about_desc CLOB NOT NULL
);

-- Table: contact_us
CREATE TABLE contact_us (
  contact_id NUMBER(10) PRIMARY KEY,
  contact_email VARCHAR2(255) NOT NULL,
  contact_heading VARCHAR2(255) NOT NULL,
  contact_desc CLOB NOT NULL
);


-- Table: store
CREATE TABLE store (
  store_id NUMBER(10) PRIMARY KEY,
  store_title VARCHAR2(255) NOT NULL,
  store_image VARCHAR2(255) NOT NULL,
  store_desc CLOB NOT NULL,
  store_button VARCHAR2(255) NOT NULL,
  store_url VARCHAR2(255) NOT NULL
);


-- Table: terms
CREATE TABLE terms (
  term_id NUMBER(10) PRIMARY KEY,
  term_title VARCHAR2(100) NOT NULL,
  term_link VARCHAR2(100) NOT NULL,
  term_desc CLOB NOT NULL
);


-- Table: payments
CREATE TABLE payments (
  payment_id NUMBER(10) PRIMARY KEY,
  invoice_no NUMBER(10) NOT NULL,
  amount NUMBER(10, 2) NOT NULL,
  payment_mode VARCHAR2(255) NOT NULL,
  ref_no NUMBER(10) NOT NULL,
  code NUMBER(10) NOT NULL,
  payment_date DATE NOT NULL
);


-- Foreign key from product_categories to products
ALTER TABLE product_categories
ADD FOREIGN KEY (p_cat_id) REFERENCES products(p_cat_id);

-- Foreign key from categories to products
ALTER TABLE categories
ADD FOREIGN KEY (cat_id) REFERENCES products(cat_id);

-- Foreign key from admins to customer_orders
ALTER TABLE admins
ADD FOREIGN KEY (admin_id) REFERENCES customer_orders(admin_id);

-- Foreign key from customers to customer_orders
ALTER TABLE customers
ADD FOREIGN KEY (customer_id) REFERENCES customer_orders(customer_id);

-- Foreign key from customers to wishlist
ALTER TABLE customers
ADD FOREIGN KEY (customer_id) REFERENCES wishlist(customer_id);

-- Foreign key from customers to cart
ALTER TABLE customers
ADD FOREIGN KEY (customer_id) REFERENCES cart(customer_id);

-- Foreign key from coupons to products
ALTER TABLE coupons
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Foreign key from coupons to bundle_product_relation
ALTER TABLE coupons
ADD FOREIGN KEY (bundle_id) REFERENCES bundle_product_relation(bundle_id);

-- Foreign key from bundle_product_relation_mapping to products
ALTER TABLE bundle_product_relation_mapping
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

-- Foreign key from bundle_product_relation_mapping to bundle_product_relation
ALTER TABLE bundle_product_relation_mapping
ADD FOREIGN KEY (bundle_id) REFERENCES bundle_product_relation(bundle_id);

-- Foreign key from pending_orders to products
ALTER TABLE pending_orders
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);

CREATE OR REPLACE PROCEDURE change_password(
    p_customer_email IN VARCHAR2,
    p_old_password IN VARCHAR2,
    p_new_password IN VARCHAR2,
    p_new_password_again IN VARCHAR2,
    p_msg OUT VARCHAR2
)
IS
    v_hashed_password VARCHAR2(255);
    v_old_password VARCHAR2(255);
BEGIN
    -- Verificar que las contraseñas nuevas coincidan
    IF p_new_password <> p_new_password_again THEN
        p_msg := 'Your New Password does not match';
        RETURN;
    END IF;
    
    -- Obtener la contraseña actual del cliente
    SELECT customer_pass INTO v_old_password
    FROM customers
    WHERE customer_email = p_customer_email;
    
    -- Verificar que la contraseña antigua coincida
    IF NOT dbms_crypto.compare(p_old_password, v_old_password) = 0 THEN
        p_msg := 'Your Current Password is not valid try again';
        RETURN;
    END IF;
    
    -- Generar el hash de la nueva contraseña
    v_hashed_password := dbms_crypto.hash(p_new_password, dbms_crypto.hash_sha256);
    
    -- Actualizar la contraseña en la tabla de clientes
    UPDATE customers
    SET customer_pass = v_hashed_password
    WHERE customer_email = p_customer_email;
    
    p_msg := 'Success';
    
EXCEPTION
    WHEN OTHERS THEN
        p_msg := 'An error occurred. Please try again later.';
END;
/

CREATE OR REPLACE PROCEDURE confirm_payment(
    p_order_id IN NUMBER,
    p_invoice_no IN VARCHAR2,
    p_amount IN NUMBER,
    p_payment_mode IN VARCHAR2,
    p_ref_no IN VARCHAR2,
    p_code IN VARCHAR2,
    p_payment_date IN DATE,
    p_msg OUT VARCHAR2
)
IS
BEGIN
    -- Insertar el pago en la tabla de pagos
    INSERT INTO payments (invoice_no, amount, payment_mode, ref_no, code, payment_date)
    VALUES (p_invoice_no, p_amount, p_payment_mode, p_ref_no, p_code, p_payment_date);
    
    -- Actualizar el estado del pedido en la tabla de órdenes de clientes
    UPDATE customer_orders
    SET order_status = 'Complete'
    WHERE order_id = p_order_id;
    
    -- Actualizar el estado del pedido en la tabla de órdenes pendientes
    UPDATE pending_orders
    SET order_status = 'Complete'
    WHERE order_id = p_order_id;
    
    p_msg := 'Success';
EXCEPTION
    WHEN OTHERS THEN
        p_msg := 'An error occurred. Please try again later.';
END;
/

CREATE OR REPLACE PROCEDURE customer_login(
    p_customer_email IN VARCHAR2,
    p_customer_pass IN VARCHAR2,
    p_login_status OUT VARCHAR2
)
IS
    v_customer_count NUMBER;
BEGIN
    -- Verificar las credenciales del cliente
    SELECT COUNT(*) INTO v_customer_count
    FROM customers
    WHERE customer_email = p_customer_email
    AND customer_pass = p_customer_pass;
    
    IF v_customer_count = 0 THEN
        p_login_status := 'password or email is wrong';
    ELSE
        p_login_status := 'Success';
    END IF;
END;
/

CREATE OR REPLACE PROCEDURE delete_customer_account(
    p_customer_email IN VARCHAR2,
    p_success OUT VARCHAR2
)
IS
BEGIN
    -- Eliminar la cuenta del cliente
    DELETE FROM customers WHERE customer_email = p_customer_email;

    -- Verificar si la cuenta ha sido eliminada correctamente
    IF SQL%ROWCOUNT > 0 THEN
        p_success := 'success';
    ELSE
        p_success := 'error';
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE delete_wishlist_item(
    p_wishlist_id IN NUMBER,
    p_success OUT VARCHAR2
)
IS
BEGIN
    -- Eliminar el elemento de la lista de deseos
    DELETE FROM wishlist WHERE wishlist_id = p_wishlist_id;

    -- Verificar si el elemento ha sido eliminado correctamente
    IF SQL%ROWCOUNT > 0 THEN
        p_success := 'success';
    ELSE
        p_success := 'error';
    END IF;
END;
/
-- Procedimiento almacenado para obtener los detalles del cliente
CREATE OR REPLACE PROCEDURE get_customer_details(
    p_email IN VARCHAR2,
    p_customer_id OUT VARCHAR2,
    p_customer_name OUT VARCHAR2,
    p_customer_country OUT VARCHAR2,
    p_customer_city OUT VARCHAR2,
    p_customer_contact OUT VARCHAR2,
    p_customer_address OUT VARCHAR2,
    p_customer_image OUT VARCHAR2
) AS
BEGIN
    SELECT customer_id, customer_name, customer_country, customer_city, customer_contact, customer_address, customer_image
    INTO p_customer_id, p_customer_name, p_customer_country, p_customer_city, p_customer_contact, p_customer_address, p_customer_image
    FROM customers
    WHERE customer_email = p_email;
END get_customer_details;
/

-- Procedimiento almacenado para confirmar el correo electrónico del cliente
CREATE OR REPLACE PROCEDURE confirm_email(
    p_confirm_code IN VARCHAR2
) AS
BEGIN
    UPDATE customers
    SET customer_confirm_code = ''
    WHERE customer_confirm_code = p_confirm_code;
    COMMIT;
END confirm_email;
/
-- Procedimiento almacenado para enviar el correo electrónico de confirmación nuevamente
CREATE OR REPLACE PROCEDURE send_confirmation_email(
    p_email IN VARCHAR2,
    p_customer_name IN VARCHAR2,
    p_confirm_code IN VARCHAR2
) AS
    v_subject VARCHAR2(100) := 'Email Confirmation Message';
    v_from VARCHAR2(100) := 'your_email@example.com';
    v_message CLOB;
    v_headers VARCHAR2(200);
BEGIN
    -- Construir el mensaje de correo electrónico
    v_message := '<h2>Email Confirmation By YourWebsite.com ' || p_customer_name || '</h2><a href="localhost/ecom_store/customer/my_account.php?' || p_confirm_code || '">Click Here To Confirm Email</a>';

    -- Construir los encabezados del correo electrónico
    v_headers := 'From: ' || v_from || CHR(13) || CHR(10);
    v_headers := v_headers || 'Content-type: text/html; charset=iso-8859-1' || CHR(13) || CHR(10);

    -- Enviar el correo electrónico
    UTL_MAIL.send(
        sender => v_from,
        recipients => p_email,
        subject => v_subject,
        message => v_message,
        mime_type => 'text/html',
        priority => 1
    );

    COMMIT;
END send_confirmation_email;
/
CREATE OR REPLACE PROCEDURE get_customer_id (
    p_customer_email IN VARCHAR2,
    p_customer_id OUT NUMBER
) AS
BEGIN
    SELECT customer_id INTO p_customer_id
    FROM customers
    WHERE customer_email = p_customer_email;
END;
/
CREATE OR REPLACE PROCEDURE get_customer_orders (
    p_customer_id IN NUMBER,
    p_order_id OUT SYS.ODCINUMBERLIST,
    p_due_amount OUT SYS.ODCINUMBERLIST,
    p_invoice_no OUT SYS.ODCINUMBERLIST,
    p_qty OUT SYS.ODCINUMBERLIST,
    p_size OUT SYS.ODCIVARCHAR2LIST,
    p_order_date OUT SYS.ODCIVARCHAR2LIST,
    p_order_status OUT SYS.ODCIVARCHAR2LIST
) AS
BEGIN
    SELECT order_id, due_amount, invoice_no, qty, size, TO_CHAR(order_date, 'YYYY-MM-DD'), order_status
    BULK COLLECT INTO p_order_id, p_due_amount, p_invoice_no, p_qty, p_size, p_order_date, p_order_status
    FROM customer_orders
    WHERE customer_id = p_customer_id;
END;
/
CREATE OR REPLACE PROCEDURE get_customer_id(
    p_customer_email IN VARCHAR2,
    p_customer_id OUT NUMBER
)
AS
BEGIN
    SELECT customer_id INTO p_customer_id
    FROM customers
    WHERE customer_email = p_customer_email;
END;
/
CREATE OR REPLACE PROCEDURE get_customer_wishlist(
    p_customer_id IN NUMBER,
    p_wishlist_id OUT SYS.ODCINUMBERLIST,
    p_product_id OUT SYS.ODCINUMBERLIST
)
AS
BEGIN
    SELECT wishlist_id, product_id
    BULK COLLECT INTO p_wishlist_id, p_product_id
    FROM wishlist
    WHERE customer_id = p_customer_id;
END;
/

CREATE OR REPLACE PROCEDURE update_customer (
    p_customer_id IN NUMBER,
    p_customer_name IN VARCHAR2,
    p_customer_email IN VARCHAR2,
    p_customer_country IN VARCHAR2,
    p_customer_city IN VARCHAR2,
    p_customer_contact IN VARCHAR2,
    p_customer_address IN VARCHAR2,
    p_customer_image IN VARCHAR2
) AS
BEGIN
    UPDATE customers
    SET customer_name = p_customer_name,
        customer_email = p_customer_email,
        customer_country = p_customer_country,
        customer_city = p_customer_city,
        customer_contact = p_customer_contact,
        customer_address = p_customer_address,
        customer_image = p_customer_image
    WHERE customer_id = p_customer_id;
    COMMIT;
END;
/
CREATE OR REPLACE PROCEDURE get_customer_wishlist(
    p_customer_id IN NUMBER,
    p_wishlist_id OUT SYS.ODCINUMBERLIST,
    p_product_id OUT SYS.ODCINUMBERLIST
)
AS
BEGIN
    SELECT wishlist_id, product_id
    BULK COLLECT INTO p_wishlist_id, p_product_id
    FROM wishlist
    WHERE customer_id = p_customer_id;
END;
/
CREATE OR REPLACE PROCEDURE get_product_details(
    p_product_id IN NUMBER,
    p_product_title OUT VARCHAR2,
    p_product_url OUT VARCHAR2,
    p_product_img1 OUT VARCHAR2
)
AS
BEGIN
    SELECT product_title, product_url, product_img1
    INTO p_product_title, p_product_url, p_product_img1
    FROM products
    WHERE product_id = p_product_id;
END;
/
-- Procedimiento para obtener la cantidad de elementos en el carrito
CREATE OR REPLACE PROCEDURE get_items_count
IS
  v_ip_add VARCHAR2(50);
  v_count_items NUMBER;
BEGIN
  -- Obtener la dirección IP real del usuario
  v_ip_add := get_real_user_ip();

  -- Consultar la base de datos para obtener los elementos del carrito para esta dirección IP
  SELECT COUNT(*) INTO v_count_items
  FROM cart
  WHERE ip_add = v_ip_add;

  -- Mostrar la cantidad de elementos
  DBMS_OUTPUT.PUT_LINE('Número de elementos: ' || v_count_items);
END get_items_count;
/


CREATE OR REPLACE PROCEDURE GET_PRODUCTS_PAGINATED (
    p_manufacturer_id IN NUMBER DEFAULT NULL,
    p_category_id IN NUMBER DEFAULT NULL,
    p_page_number IN NUMBER,
    p_page_size IN NUMBER
)
IS
    v_start_index NUMBER;
    v_end_index NUMBER;
BEGIN
    -- Calcular los índices de inicio y fin para la paginación
    v_start_index := (p_page_number - 1) * p_page_size + 1;
    v_end_index := p_page_number * p_page_size;

    -- Consulta para obtener los productos filtrados y paginados
    FOR product_row IN (
        SELECT *
        FROM (
            SELECT 
                p.*,
                ROW_NUMBER() OVER (ORDER BY product_id) AS row_num
            FROM 
                products p
            WHERE 
                (p_manufacturer_id IS NULL OR manufacturer_id = p_manufacturer_id)
                AND (p_category_id IS NULL OR category_id = p_category_id)
        )
        WHERE 
            row_num BETWEEN v_start_index AND v_end_index
    )
    LOOP
        -- Devolver los resultados (puedes modificar esto según tu estructura de datos)
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || product_row.product_id || ', Product Name: ' || product_row.product_name);
        -- Agrega más columnas según tus necesidades
    END LOOP;
END;
/

CREATE OR REPLACE PROCEDURE Get_Paginator_Paginated (
    p_manufacturer_id    IN NUMBER DEFAULT NULL,
    p_p_cat_id           IN NUMBER DEFAULT NULL,
    p_cat_id             IN NUMBER DEFAULT NULL,
    p_per_page           IN NUMBER DEFAULT 6,
    p_page               IN NUMBER DEFAULT 1
) AS
    per_page NUMBER := p_per_page;
    start_from NUMBER := (p_page - 1) * per_page;
    total_records NUMBER;
    total_pages NUMBER;
BEGIN
    -- Consultar el número total de registros
    SELECT COUNT(*) INTO total_records
    FROM products
    WHERE (p_manufacturer_id IS NULL OR manufacturer_id = p_manufacturer_id)
    AND (p_p_cat_id IS NULL OR p_cat_id = p_p_cat_id)
    AND (p_cat_id IS NULL OR cat_id = p_cat_id);

    -- Calcular el número total de páginas
    total_pages := CEIL(total_records / per_page);

    -- Generar el HTML para la paginación
    DBMS_OUTPUT.PUT_LINE('<li><a href="shop.php?page=1' || CASE WHEN p_manufacturer_id IS NOT NULL THEN '&man[]=' || p_manufacturer_id ELSE '' END || CASE WHEN p_p_cat_id IS NOT NULL THEN '&p_cat[]=' || p_p_cat_id ELSE '' END || CASE WHEN p_cat_id IS NOT NULL THEN '&cat[]=' || p_cat_id ELSE '' END || '">First Page</a></li>');

    FOR i IN 1..5 -- Ejemplo de 5 páginas
        DBMS_OUTPUT.PUT_LINE('<li><a href="shop.php?page=' || i || CASE WHEN p_manufacturer_id IS NOT NULL THEN '&man[]=' || p_manufacturer_id ELSE '' END || CASE WHEN p_p_cat_id IS NOT NULL THEN '&p_cat[]=' || p_p_cat_id ELSE '' END || CASE WHEN p_cat_id IS NOT NULL THEN '&cat[]=' || p_cat_id ELSE '' END || '">' || i || '</a></li>');
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('<li><a href="shop.php?page=' || total_pages || CASE WHEN p_manufacturer_id IS NOT NULL THEN '&man[]=' || p_manufacturer_id ELSE '' END || CASE WHEN p_p_cat_id IS NOT NULL THEN '&p_cat[]=' || p_p_cat_id ELSE '' END || CASE WHEN p_cat_id IS NOT NULL THEN '&cat[]=' || p_cat_id ELSE '' END || '">Last Page</a></li>');
END Get_Paginator_Paginated;
/

CREATE OR REPLACE PROCEDURE get_cart_items(
    ip_address IN VARCHAR2,
    cart_items OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN cart_items FOR
    SELECT p_id, qty, p_price
    FROM cart
    WHERE ip_add = ip_address;
END;
/

CREATE OR REPLACE PROCEDURE get_paginator
AS
BEGIN
  -- Aquí puedes calcular la paginación y generar el HTML correspondiente para los enlaces de paginación
  FOR i IN 1..5 -- Ejemplo de 5 páginas
  LOOP
    DBMS_OUTPUT.PUT_LINE('<li><a href="shop.php?page=' || i || '">' || i || '</a></li>');
  END LOOP;
END;
/
CREATE OR REPLACE PROCEDURE get_products
AS
BEGIN
  FOR product IN (SELECT * FROM products)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Product ID: ' || product.product_id || ', Product Title: ' || product.product_title || ', Product Price: ' || product.product_price);
    -- Puedes procesar cada fila de resultados según sea necesario
  END LOOP;
END;
/
