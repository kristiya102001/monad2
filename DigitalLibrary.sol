// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract DigitalLibrary {
    struct Book {
        string title;
        string author;
        string content;
        address uploader;
        uint256 uploadDate;
        bool isPublic;
    }

    mapping(uint256 => Book) public books;
    uint256 public bookCount;

    event BookUploaded(uint256 indexed bookId, string title, string author, address uploader);
    event BookMadePublic(uint256 indexed bookId);

    function uploadBook(string memory _title, string memory _author, string memory _content, bool _isPublic) public {
        books[bookCount] = Book({
            title: _title,
            author: _author,
            content: _content,
            uploader: msg.sender,
            uploadDate: block.timestamp,
            isPublic: _isPublic
        });
        emit BookUploaded(bookCount, _title, _author, msg.sender);
        bookCount++;
    }

    function makeBookPublic(uint256 _bookId) public {
        Book storage book = books[_bookId];
        require(book.uploader == msg.sender, "Not the uploader");
        book.isPublic = true;
        emit BookMadePublic(_bookId);
    }

    function getBook(uint256 _bookId) public view returns (string memory, string memory, string memory, address, uint256, bool) {
        Book storage book = books[_bookId];
        require(book.isPublic || book.uploader == msg.sender, "Book is not public and you are not the uploader");
        return (book.title, book.author, book.content, book.uploader, book.uploadDate, book.isPublic);
    }
}