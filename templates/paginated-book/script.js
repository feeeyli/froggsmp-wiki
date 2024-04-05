function navPage($book, mod) {
  var newPage = Number($book.attr("data-actual-page")) + mod;
  var contents = $book.find(".paginated-book__content").length;

  if (newPage <= 0 || newPage > contents) return;

  $book.attr("data-actual-page", newPage);
  $book.find(".paginated-book__content.--active").removeClass("--active");
  $book
    .find(
      ".paginated-book__content-container .paginated-book__content:nth-child(" +
        newPage +
        ")"
    )
    .addClass("--active");
  $book
    .find(".paginated-book__page-indicator")
    .text("Página " + newPage + " de " + contents);
}

$(".paginated-book__prev").on("click", function (event) {
  navPage($(event.target.closest(".paginated-book")), -1);
});

$(".paginated-book__next").on("click", function (event) {
  navPage($(event.target.closest(".paginated-book")), 1);
});
