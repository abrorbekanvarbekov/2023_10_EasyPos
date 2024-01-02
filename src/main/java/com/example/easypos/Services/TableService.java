//package com.example.easypos.Services;
//
//import com.example.easypos.DAO.TableDao;
//import com.example.easypos.Vo.*;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//public class TableService {
//    private TableDao tableDao;
//
//    @Autowired
//
//    public TableService(TableDao tableDao) {
//        this.tableDao = tableDao;
//    }
//
//    public List<Table> getTableLIst(int floor) {
//        return tableDao.getTableList(floor);
//    }
//
//    public void updateTablePos(int elPosX, int elPosY, int number, int floor) {
//        tableDao.updateTablePos(elPosX, elPosY, number, floor);
//    }
//
//    public List<ProductType> getProductTypes() {
//        return tableDao.getProductTypes();
//    }
//
//    public Product getProductById(int id) {
//        return tableDao.getProductById(id);
//    }
//
//    public List<Product> getProductList() {
//        return tableDao.getProductList();
//    }
//
//    public void insertCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor, int cart_id) {
//        tableDao.insertCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor, cart_id);
//    }
//
//    public List<CartItems> getCartItemsList(int tableId, int floor) {
//        return tableDao.getCartItemsList(tableId, floor);
//    }
//
//    public CartItems getCartItem(int productId, int tabId, int floor) {
//        return tableDao.getCartItem(productId, tabId, floor);
//    }
//
//    public int updateCartItems(int productId, int productCnt, int productSailPrice, int productPrices, String productName, int tabId, int floor) {
//        return tableDao.updateCartItems(productId, productCnt, productSailPrice, productPrices, productName, tabId, floor);
//    }
//
//    public List<CartItems> getCartItems(int floor) {
//        return tableDao.getCartItems(floor);
//    }
//
//    public List<CartItems> getPriceSumList(int floor) {
//        return tableDao.getPriceSumList(floor);
//    }
//
//    public int getTotalQuantity(int tabId, int floor) {
//        return tableDao.getTotalQuantity(tabId, floor);
//    }
//
//    public int getTotalSumPrice(int tabId, int floor) {
//        return tableDao.getTotalSumPrice(tabId, floor);
//    }
//
//    public void cancelProduct(int productId, int tabId, int floor) {
//        tableDao.cancelProduct(productId, tabId, floor);
//    }
//
//
//    public List<CartItems> getCurrCartItem(int currTableNum, int floor) {
//        return tableDao.getCurrCartItem(currTableNum, floor);
//    }
//
//    public void toMoveCartItems(int product_id, String productName, int table_id, int quantity, int productPrice,
//                                int productSumPrice, int productSailPrice, int floor_id, int cart_id) {
//        tableDao.toMoveCartItems(product_id, productName, table_id, quantity, productPrice,productSumPrice,productSailPrice,floor_id,cart_id);
//    }
//
//    public void delBeforeCartItem(int currTableNum, int floor) {
//        tableDao.delBeforeCartItem(currTableNum, floor);
//    }
//
//    public void toMoveUpdateCartItems(int afterTableNum, int floor, int productId, int quantity, int productSailPrice, int productSumPrice, int cart_id) {
//        tableDao.toMoveUpdateCartItems(afterTableNum, floor, productId, quantity, productSailPrice, productSumPrice, cart_id);
//    }
//
//    public List<TableGroup> getTableGroups() {
//        return tableDao.getTableGroups();
//    }
//
//    public void addTableGroup(String color) {
//        tableDao.addTableGroup(color);
//    }
//
//    public void removeTableGroup(int groupId) {
//        tableDao.removeTableGroup(groupId);
//    }
//
//    public void truncateForTableGroups() {
//        tableDao.truncateForTableGroups();
//    }
//
//    public void updateTableGroup(int groupId) {
//        tableDao.updateTableGroup(groupId);
//    }
//
//    public TableGroup getTableGroupById(int groupId) {
//        return tableDao.getTableGroupById(groupId);
//    }
//
//    public List<CartItems> getOrderTablesList(int i) {
//        return tableDao.getOrderTablesList(i);
//    }
//
//    public void freeProductUpdate(int productId, int tabId, int floor, String productName, int productSailPrice) {
//        tableDao.freeProductUpdate(productId, tabId, floor, productName, productSailPrice);
//    }
//
//    public void cancelFreeProduct(int productId, int tabId, int floor, String productName, int productSailPrice) {
//        tableDao.cancelFreeProduct(productId, tabId, floor, productName, productSailPrice);
//    }
//
//    public void insertPaymentCash(int floor, int tabId, int totalAmount, int splitAmount, int cashTotalSailAmount, int cart_id) {
//        tableDao.insertPaymentCash(floor, tabId, totalAmount, splitAmount, cashTotalSailAmount, cart_id);
//    }
//
//    public void insertPaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String payByCreditCartNumber, int cart_id) {
//        tableDao.insertPaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, payByCreditCartNumber, cart_id);
//    }
//
//    public Product getProductName(int productId) {
//        return tableDao.getProductName(productId);
//    }
//
//    public void removePaidCartItem(int floor, int tabId) {
//        tableDao.removePaidCartItem(floor, tabId);
//    }
//
//    public List<Integer> getPayedTotalAmount(String floor) {
//        return tableDao.getPayedTotalAmount(floor);
//    }
//
//    public List<Integer> getPayedTotalCnt(String floor) {
//        return tableDao.getPayedTotalCnt(floor);
//    }
//
//    public List<Integer> getPayedTotalDiscountAmount(String floor) {
//        return tableDao.getPayedTotalDiscountAmount(floor);
//    }
//
//    public int getOutstandingAmount() {
//        return tableDao.getOutstandingAmount();
//    }
//
//    public int getDiscountSumAmount(int tabNum, int floor) {
//        return tableDao.getDiscountSumAmount(tabNum, floor);
//    }
//
//    public int getTotalSailPrice(int tabId, int floor) {
//        return tableDao.getTotalSailPrice(tabId, floor);
//    }
//
//    public void updatePaymentCreditCart(int floor, int tabId, int totalAmount, int splitAmount, int cartTotalSailAmount, String creditCartNumber, int id) {
//        tableDao.updatePaymentCreditCart(floor, tabId, totalAmount, splitAmount, cartTotalSailAmount, creditCartNumber, id);
//    }
//
//    public int paymentCreditCartAndCashLastId() {
//        return tableDao.paymentCreditCartAndCashLastId();
//    }
//
//    public Cart getCart(int floor, int tabId) {
//        return tableDao.getCart(floor, tabId);
//    }
//
//    public void createCart(int floor, int tabId) {
//        tableDao.createCart(floor, tabId);
//    }
//
//    public void removeCart(int floor, int tabId) {
//        tableDao.removeCart(floor, tabId);
//    }
//
//    public void updateCart(int floor, int afterTableNum, int currTableNum) {
//        tableDao.updateCart(floor, afterTableNum, currTableNum);
//    }
//}
