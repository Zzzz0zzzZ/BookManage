package book.manage.entity;

import lombok.Data;

@Data
public class Book {
    int bid;
    final String title;
    final String desc;
    final double price;
}
