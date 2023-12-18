CREATE TABLE Order_iagboada (
    oid INT(11) AUTO_INCREMENT PRIMARY KEY,
    order_datetime DATETIME NOT NULL,
    order_qty INT(10) UNSIGNED NOT NULL,
    cid INT(11) NOT NULL,
    pid INT(11) NOT NULL,
    CONSTRAINT fk_cid FOREIGN KEY (cid) REFERENCES CPS3740.Customers(id),
    CONSTRAINT fk_pid FOREIGN KEY (pid) REFERENCES CPS3740.Products(P_Id),
    CHECK (order_qty > 0)
);