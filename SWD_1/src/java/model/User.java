/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *hieunthe181854
 */
public class User {
    private int userid;
    private String fullname;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String status;
    private Date createdat;

    public User() {
    }

    public User(int userid, String fullname, String email, String phone, String password, String role, String status, Date createdat) {
        this.userid = userid;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.status = status;
        this.createdat = createdat;
    }

    public int getUserid() {
        return userid;
    }

    public String getFullname() {
        return fullname;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    public String getStatus() {
        return status;
    }

    public Date getCreatedat() {
        return createdat;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreatedat(Date createdat) {
        this.createdat = createdat;
    }
    
    
}
