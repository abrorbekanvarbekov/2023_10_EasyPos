
package com.example.easypos.Services;

import com.example.easypos.DAO.HomeDao;
import com.example.easypos.Vo.Cart;
import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Table;
import com.example.easypos.Vo.TableGroup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HomeService {
    private HomeDao homeDao;

    @Autowired
    public HomeService(HomeDao homeDao) {
        this.homeDao = homeDao;
    }

    public List<CartItems> getCartItems(int floor, String openingDate) {
        return homeDao.getCartItems(floor, openingDate);
    }

    public List<Table> getTableLIst(int floor) {
        return homeDao.getTableList(floor);
    }

    public List<CartItems> getPriceSumList(int floor, String openingDate) {
        return homeDao.getPriceSumList(floor, openingDate);
    }

    public List<TableGroup> getTableGroups() {
        return homeDao.getTableGroups();
    }

    public List<CartItems> getOrderTablesList(int i, String openingDate) {
        return homeDao.getOrderTablesList(i, openingDate);
    }

    // ==============================================================//

    public void updateTablePos(int elPosX, int elPosY, String tableName, int floor) {
        homeDao.updateTablePos(elPosX, elPosY, tableName, floor);
    }

    // ==============================================================//

    public List<Integer> getPayedTotalAmount(String floor, String openingDate) {
        return homeDao.getPayedTotalAmount(floor, openingDate);
    }

    public List<Integer> getPayedTotalCnt(String floor, String openingDate) {
        return homeDao.getPayedTotalCnt(floor, openingDate);
    }

    public List<Integer> getPayedTotalDiscountAmount(String floor, String openingDate) {
        return homeDao.getPayedTotalDiscountAmount(floor, openingDate);
    }

    public int getOutstandingAmount(String floor, String openingDate) {
        return homeDao.getOutstandingAmount(floor, openingDate);
    }

    public List<Integer> getNumberOfReturns(String floor, String openingDate) {
        return homeDao.getNumberOfReturns(floor, openingDate);
    }

    public List<Integer> getAmountOfReturns(String floor, String openingDate) {
        return homeDao.getAmountOfReturns(floor, openingDate);
    }

    public int getOutstandingTables(String floor) {
        return homeDao.getOutstandingTables(floor);
    }
    // ==============================================================//

    public List<CartItems> getCurrCartItem(int currTableNum, int floor) {
        return homeDao.getCurrCartItem(currTableNum, floor);
    }

    public void removeCart(int floor, int tabId) {
        homeDao.removeCart(floor, tabId);
    }

    public Cart getCart(int floor, int tabId) {
        return homeDao.getCart(floor, tabId);
    }

    public CartItems getCartItem(int productId, int tabId, int floor) {
        return homeDao.getCartItem(productId, tabId, floor);
    }

    public void toMoveCartItems(String openingDate, int product_id, String productName, int table_id, int quantity, int productPrice,
                                int productSumPrice, int productSailPrice, int floor_id, int cart_id) {
        homeDao.toMoveCartItems(openingDate, product_id, productName, table_id, quantity, productPrice, productSumPrice, productSailPrice, floor_id, cart_id);
    }

    public void toMoveUpdateCartItems(int afterTableNum, int floor, int productId, int quantity, int productSailPrice, int productSumPrice, int cart_id) {
        homeDao.toMoveUpdateCartItems(afterTableNum, floor, productId, quantity, productSailPrice, productSumPrice, cart_id);
    }

    public void updateCart(int floor, int afterTableNum, int currTableNum) {
        homeDao.updateCart(floor, afterTableNum, currTableNum);
    }

    public void delBeforeCartItem(int currTableNum, int floor) {
        homeDao.delBeforeCartItem(currTableNum, floor);
    }

    // ==============================================================//

    public void addTableGroup(String color) {
        homeDao.addTableGroup(color);
    }

    public void removeTableGroup(int groupId) {
        homeDao.removeTableGroup(groupId);
    }

    public void truncateForTableGroups() {
        homeDao.truncateForTableGroups();
    }

    public void updateTableGroup(int groupId) {
        homeDao.updateTableGroup(groupId);
    }

    public TableGroup getTableGroupById(int groupId) {
        return homeDao.getTableGroupById(groupId);
    }

    // ==============================================================//

    public List<CartItems> getCartItemsList(int tableId, int floor) {
        return homeDao.getCartItemsList(tableId, floor);
    }

}
