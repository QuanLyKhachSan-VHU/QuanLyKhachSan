USE quan_ly_khach_san;

START TRANSACTION;

-- Tạo loại phòng thử
INSERT INTO loai_phong (
    ten_loai_phong,
    gia_mac_dinh,
    so_nguoi_toi_da
)
VALUES (
    CONCAT('TEST_', UUID()),
    500000,
    2
);

SET @loai_phong_test = LAST_INSERT_ID();

-- Tạo phòng thuộc loại phòng vừa thêm
INSERT INTO phong (
    ma_loai_phong,
    so_phong,
    tang,
    gia_phong,
    trang_thai_van_hanh
)
VALUES (
    @loai_phong_test,
    LEFT(UUID(), 20),
    1,
    500000,
    'SAN_SANG'
);

SET @phong_test = LAST_INSERT_ID();

-- Hiển thị phòng và loại phòng liên kết
SELECT
    p.ma_phong,
    p.so_phong,
    lp.ma_loai_phong,
    lp.ten_loai_phong
FROM phong AS p
JOIN loai_phong AS lp
    ON p.ma_loai_phong = lp.ma_loai_phong
WHERE p.ma_phong = @phong_test;
DELETE FROM loai_phong
WHERE ma_loai_phong = @loai_phong_test;
ROLLBACK;
SELECT COUNT(*) AS so_phong_test_con_lai
FROM phong
WHERE ma_phong = @phong_test;

SELECT COUNT(*) AS so_loai_phong_test_con_lai
FROM loai_phong
WHERE ma_loai_phong = @loai_phong_test;