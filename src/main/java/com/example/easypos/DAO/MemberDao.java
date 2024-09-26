package com.example.easypos.DAO;

import com.example.easypos.Vo.Employee;
import com.example.easypos.Vo.Members;
import org.apache.ibatis.annotations.*;

import java.util.List;


@Mapper
public interface MemberDao {

    @Select("""
            select *
            from member
            where loginId = #{loginId}
            and loginPw = #{loginPw};
            """)
    Members getMember(String loginId, String loginPw);

    @Select("""
            select * from member
                    where loginId = #{loginId}
            """)
    Members doLogin(String loginId);

    @Select("""
            select *from member
                    where id = #{loginedMemberId}
            """)
    Members getMemberById(int loginedMemberId);

    @Select("""
            select * from employee 
            """)
    List<Employee> getEmployeeList();

    @Select("""
            select * from employee
            where employeeCode = #{employeeCode}
            """)
    Employee getEmployee(int employeeCode);
}
