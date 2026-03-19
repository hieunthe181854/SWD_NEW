/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
/**
 *hieunthe181854
 */
public class DriverDAO {
    Connection conn;

    public DriverDAO(Connection conn) {
        this.conn = conn;
    }

    public int findAvailableDriver() throws Exception {
        String sql = "SELECT TOP 1 dp.DriverID " +
                "FROM DriverProfiles dp " +
                "JOIN Users u ON dp.DriverID = u.UserID " +
                "WHERE dp.VerificationStatus = 'Verified' " +
                "AND dp.WorkingStatus = 'Online'";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) return rs.getInt("DriverID");
        return -1;
    }
}
