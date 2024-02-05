let product_list_box = document.querySelector("#selectedManuList-1 li:last-child")

if (product_list_box != null) {
    product_list_box.style.backgroundColor = "aqua";
    product_list_box.classList.add("checked")
}

document.querySelectorAll(".product-box-list").forEach((element) => {
    element.addEventListener("click", (e) => {
        product_list_box.style.backgroundColor = "inherit";
        product_list_box.classList.remove("checked")
        product_list_box = element
        let id = e.target.id.substring(e.target.id.indexOf("_") + 1, e.target.id.lastIndex)
        const el = document.querySelector(".product-box-list_" + id)
        el.style.backgroundColor = "aqua"
        el.classList.add("checked")
    })
})