# ASSESSMENT_GEEKUP

## Mô tả dự án
Dự án này là một ứng dụng e-commerce được xây dựng bằng **Spring Boot**, hỗ trợ quản lý đơn hàng, sản phẩm, người dùng, địa chỉ, cửa hàng, và gửi email xác nhận đơn hàng bất đồng bộ. Dự án đáp ứng các yêu cầu của bài tập, bao gồm:
- **Câu a**: Tạo cơ sở dữ liệu với các bảng như `users`, `addresses`, `products`, `orders`, `order_details`, v.v., sử dụng chuẩn hóa 1NF, 2NF, 3NF.
- **Câu b, c và d**: Xử lý logic truy vấn.
- **Câu e **: Xử lý logic đặt hàng, xem danh sách sản phẩm, danh mục và gửi email xác nhận, yêu cầu dữ liệu mẫu để kiểm tra.

## Yêu cầu hệ thống
- **Java**: 17 hoặc cao hơn.
- **Maven**: 3.6.0 hoặc cao hơn.
- **MySQL**: 8.0 hoặc cao hơn.
- **SMTP Server**: Gmail (hoặc dịch vụ SMTP khác) để gửi email.
- **IDE**: IntelliJ IDEA (khuyến nghị).

## Cấu trúc thư mục
```
ecommerce/
├── src/
│   ├── main/
│   │   ├── java/com/assessment/ecommerce/
│   │   ├── resources/
│   │   │   ├── application.yml
│   │   │   └── sql/
│   │   │       ├── script1.sql
│   │   │       ├── script2.sql
├── pom.xml
├── Answer_The_Question.pdf
├── README.md
```

- **`script1.sql`**: Chứa lệnh tạo cơ sở dữ liệu và bảng (đáp ứng câu a,  b).
- **`script2.sql`**: Chứa dữ liệu mẫu (INSERT) để chạy cho câu c và d.
- **`Answer_The_Question.pdf`**: Chứa các câu trả lời cho toàn bộ bài, câu hỏi e - đặc tả api.

## Hướng dẫn thiết lập và chạy dự án

### 1. Tải dự án
Clone repository từ GitHub:
```bash
git clone https://github.com/SeaStone01202/ASSESSMENT_GEEKUP.git
cd ecommerce
```

### 2. Cấu hình biến môi trường
Dự án sử dụng file `application.yml` (`src/main/resources/application.yml`) với các biến môi trường để kết nối cơ sở dữ liệu và SMTP. Tạo file `.env` hoặc cấu hình biến môi trường với các key sau:

```plaintext
# Database
DATABASE_URL=jdbc:mysql://localhost:3306/ecommerce
DATABASE_USERNAME=root
DATABASE_PASSWORD=admin123

# SMTP (Gmail)
SPRING_MAIL_USERNAME=<your_gmail_address>
SPRING_MAIL_PASSWORD=<your_gmail_app_password>
```

### 3. Cấu hình cơ sở dữ liệu
1. Tạo cơ sở dữ liệu MySQL:
   ```sql
   CREATE DATABASE ecommerce_db;
   ```
2. Chạy file `script1.sql` để tạo bảng (đáp ứng câu b):
   - Sử dụng MySQL Workbench hoặc lệnh:
     ```bash
     mysql -u <your_username> -p ecommerce_db < src/main/resources/sql/script1.sql
     ```
3. Chạy file `script2.sql` để chèn dữ liệu mẫu (cần cho câu c và d):
   ```bash
   mysql -u <your_username> -p ecommerce_db < src/main/resources/sql/script2.sql
   ```

### 4. Cài đặt và chạy ứng dụng
1. Mở dự án trong IntelliJ IDEA hoặc IDE tương tự.
2. Cài đặt dependencies:
   ```bash
   mvn clean install -DskipTests
   ```
3. Chạy ứng dụng:
   ```bash
   mvn spring-boot:run
   ```
   Hoặc chạy từ IDE bằng class `EcommerceApplication`.

Ứng dụng sẽ chạy tại `http://localhost:8080`.

### 5. Kiểm tra API
Sử dụng Postman để kiểm tra API `POST /api/orders` (đáp ứng câu e.4 và e.5):
- **Endpoint**: `POST http://localhost:8080/api/orders`
- **Body** (JSON):
  ```json
  {
    "userId": 1,
    "addressId": 1,
    "paymentMethod": "COD",
    "voucherCode": "DISCOUNT10",
    "items": [
      {
        "variantId": 1,
        "storeId": 1,
        "quantity": 2,
        "unitPrice": 980000.00
      }
    ]
  }
  ```
- **Kết quả mong đợi**:
  - Trả về mã trạng thái `201 Created` với chi tiết đơn hàng.
  - Email xác nhận được gửi bất đồng bộ đến `testuser@example.com` (được chèn trong `script2.sql`).

