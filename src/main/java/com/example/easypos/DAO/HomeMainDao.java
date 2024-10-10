package com.example.easypos.DAO;

import com.example.easypos.Vo.CartItems;
import com.example.easypos.Vo.Table;
import com.example.easypos.Vo.deadlineSettlement;
import com.example.easypos.Vo.paymentCreditCardAndCash;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface HomeMainDao {

    @Select("""
            select tabId, floor, cart_id, CashAmountPaid, CardAmountPaid,totalAmount,regDate,isReturn,discountAmount,
                        ifnull(sum(CashAmountPaid), 0) as sumCashAmountPaid,
                        ifnull(sum(CardAmountPaid), 0) as sumCardAmountPaid
            from paymentCreditCardAndCash
                 WHERE floor = #{floor}
                   and regDate > #{beginDate}
                   and regDate < #{endDate}
                 group by regDate
            """)
    List<paymentCreditCardAndCash> getPaymentCartAndCashList(String beginDate, String endDate, String floor);

    @Select("""
            select cartI.*, pay.CardAmountPaid, pay.CashAmountPaid, pay.totalAmount, pay.discountAmount
                from CartItems as cartI
                         inner join paymentCreditCardAndCash as pay
                                    on cartI.cart_id = pay.cart_id
                where cartI.cart_id = #{cartId}
                and cartI.openingDate = #{openingDate}
                group by cartI.productName
            """)
    List<CartItems> getCartItemsByCart_id(int cartId, String openingDate);


    @Update("""
            update paymentCreditCardAndCash
                set isReturn = 2
                    where cart_id = #{cartId}
                    and openingDate = #{openingDate}
            """)
    int returnPaymentCartAndCash(int cartId, String openingDate);


    @Insert("""
            insert into paymentCreditCardAndCash(regDate, updateDate, openingDate, tabId, floor, totalAmount, CardAmountPaid, CashAmountPaid,
                                                 discountAmount, payByCreditCardNumber, cart_id, isReturn)
            select now(),
                   updateDate,
                   #{openingDate},
                   tabId,
                   floor,
                   totalAmount,
                   CardAmountPaid,
                   CashAmountPaid,
                   discountAmount,
                   payByCreditCardNumber,
                   cart_id,
                   1
            from paymentCreditCardAndCash
                where paymentCreditCardAndCash.cart_id = #{cartId}
                and paymentCreditCardAndCash.openingDate = #{openingDate}
            """)
    void insertReturnPayment(int cartId, String openingDate);

    @Delete("""
            delete from paymentCreditCard
                where cart_id = #{cartId}
                and openingDate = #{openingDate}
            """)
    void cancelReturnPaymentCart(int cartId, String openingDate);

    @Delete("""
            delete from paymentCash
                where cart_id = #{cartId}
                and openingDate = #{openingDate}
            """)
    void cancelReturnPaymentCash(int cartId, String openingDate);

    List<Integer> getPayedTotalAmount(String floor, String openingDate);

    List<Integer> getPayedTotalCnt(String floor, String openingDate);

    List<Integer> getPayedTotalDiscountAmount(String floor, String openingDate);

    List<Integer> getNumberOfReturns(String floor, String openingDate);

    List<Integer> getAmountOfReturns(String floor, String openingDate);

    int getOutstandingAmount(String floor, String openingDate);

    @Select("""
            select count(distinct table_id) from CartItems
                where delStatus = 0
                and openingDate = #{openingDate}
            """)
    int getOutstandingTables(String floor, String openingDate);

    @Insert("""
            insert into deadlineSettlement
            set openingDate = #{openingDate},
                closeDate = now(),
                openEmployeeName = #{openEmployeeName},
                openEmployeeCode = #{openEmployeeCode},
                closeEmployeeName = #{closeEmployeeName},
                closeEmployeeCode = #{closeEmployeeCode},
                totalSales = #{totalSales},
                totalSalesCount = #{totalSalesCount},
                discountAmount = #{discountAmount},
                VAT = #{VAT},
                NETSales = #{NETSales},
                amountOfReturns = #{amountOfReturns},
                paidByCash = #{paidByCash},
                paidByCard = #{paidByCard}
            """)
    void insertDeadlineSettlement(String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName,
                                  String closeEmployeeCode, int totalSales, int totalSalesCount,
                                  int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCard);

    @Select("""
            select * from deadlineSettlement
            where openingDate = #{openingDate}
            limit 1
            """)
    deadlineSettlement getDeadlineSettlement(String openingDate);

    @Update("""
            update deadlineSettlement
                set openingDate = #{openingDate},
                    closeDate = now(),
                    openEmployeeName = #{openEmployeeName},
                    openEmployeeCode = #{openEmployeeCode},
                    closeEmployeeName = #{closeEmployeeName},
                    closeEmployeeCode = #{closeEmployeeCode},
                    totalSales = #{totalSales},
                    totalSalesCount = #{totalSalesCount},
                    discountAmount = #{discountAmount},
                    VAT = #{VAT},
                    NETSales = #{NETSales},
                    amountOfReturns = #{amountOfReturns},
                    paidByCash = #{paidByCash},
                    paidByCard = #{paidByCard}
                where openingDate = #{openingDate}
                and id = #{id}
            """)
    void updateDeadlineSettlement(int id, String openingDate, String openEmployeeName, String openEmployeeCode, String closeEmployeeName, String closeEmployeeCode, int totalSales, int totalSalesCount,
                                  int discountAmount, int VAT, int NETSales, int amountOfReturns, int paidByCash, int paidByCard);

    @Update("""
            delete from CartItems
                where openingDate = #{businessDate}
                and delStatus = 0
            """)
    void removeLeftCartItem(String businessDate);

    @Update("""
            delete from Cart
                where openingDate = #{businessDate}
            """)
    void removeLeftCart(String businessDate);

    @Insert("""
            insert into `table` (
                                 regDate, updateDate, tableName, width, height, `left`, top, 
                                 border_radius, authLevel, floor, lastTableNum, bgColor
            ) SELECT now(),
                     now(),
                     #{tableNum},
                     #{width},
                     #{height},
                     #{top},
                     #{left},
                     #{border_radius},
                     1,
                     #{floor},
                     #{tableNum},
                     #{tableColor}
            """)
    int createTable(int tableNum, String tableColor, int floor, int width, int height, int top, int left, int border_radius);

    @Select("""
            select * from `table`
                where floor = #{floor}
            """)
    List<Table> getTableList(int floor);

    @Update("""
            update `table`
            set updateDate = now(),
                width = #{width},
                height = #{height},
                `left` = #{elPosX},
                `top` = #{elPosY},
                tableName = #{number}
            where id = #{tableId}
            and floor = #{floor}
            """)
    int updateTable(int width, int height, int elPosX, int elPosY, int number, int floor, int tableId);

    @Delete("""
            delete from `table`
                where floor = #{floor}
                and id = #{tableId};
            """)
    void deleteTable(String tableId, int floor);
}