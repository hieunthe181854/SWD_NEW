/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import model.Booking;
/**
 *hieunthe181854
 */
public class BookingDAO {
    Connection conn;

    public BookingDAO(Connection conn) {
        this.conn = conn;
    }

    public int createBooking(Booking b) throws Exception {
        String sql = "INSERT INTO Bookings (CustomerID, PickupAddress, DestinationAddress, " +
                "PickupLatitude, PickupLongitude, DestinationLatitude, DestinationLongitude, " +
                "BookingTime, Status, EstimatedPrice) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), 'Pending', ?)";

        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, b.getCustomerID());
        ps.setString(2, b.getPickupAddress());
        ps.setString(3, b.getDestinationAddress());
        ps.setDouble(4, b.getPickupLat());
        ps.setDouble(5, b.getPickupLng());
        ps.setDouble(6, b.getDestLat());
        ps.setDouble(7, b.getDestLng());
        ps.setDouble(8, b.getEstimatedPrice());

        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) return rs.getInt(1);
        return -1;
    }

    public void assignDriver(int bookingID, int driverID) throws Exception {
        String sql = "UPDATE Bookings SET DriverID = ? WHERE BookingID = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, driverID);
        ps.setInt(2, bookingID);
        ps.executeUpdate();
    }
}
