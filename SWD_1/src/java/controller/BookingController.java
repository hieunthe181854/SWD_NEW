/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

/**
 *hieunthe181854
 */
import dal.BookingDAO;
import dal.DBContext;
import dal.DriverDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Booking;
import java.sql.Connection;

/**
 *
 * @author admin
 */
@WebServlet(name = "BookingController", urlPatterns = {"/booking"})
public class BookingController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            double pickupLat = Double.parseDouble(request.getParameter("pickupLat"));
            double pickupLng = Double.parseDouble(request.getParameter("pickupLng"));
            double destLat = Double.parseDouble(request.getParameter("destLat"));
            double destLng = Double.parseDouble(request.getParameter("destLng"));

            double price = calculateDistance(pickupLat, pickupLng, destLat, destLng) * 10000;

            // ======================
            // STEP 1: XEM GIÁ
            // ======================
            if ("calculate".equals(action)) {

                request.setAttribute("estimatedPrice", (int) price);

                // giữ lại dữ liệu để không mất input
                request.setAttribute("pickupLat", pickupLat);
                request.setAttribute("pickupLng", pickupLng);
                request.setAttribute("destLat", destLat);
                request.setAttribute("destLng", destLng);

                request.getRequestDispatcher("customer/booking.jsp").forward(request, response);
                return;
            }

            // ======================
            // STEP 2: XÁC NHẬN
            // ======================
            if ("confirm".equals(action)) {

                Connection conn = new DBContext().getConnection();

                Booking b = new Booking();
                b.setCustomerID(1); // demo
                b.setPickupLat(pickupLat);
                b.setPickupLng(pickupLng);
                b.setDestLat(destLat);
                b.setDestLng(destLng);
                b.setEstimatedPrice(price);

                BookingDAO bookingDAO = new BookingDAO(conn);
                DriverDAO driverDAO = new DriverDAO(conn);

                int bookingID = bookingDAO.createBooking(b);
                int driverID = driverDAO.findAvailableDriver();

                if (driverID != -1) {
                    bookingDAO.assignDriver(bookingID, driverID);
                }

                HttpSession session = request.getSession();
                session.setAttribute("message", "Đặt tài xế thành công!");

                response.sendRedirect("customer/booking.jsp");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi: " + e.getMessage());
        }
    }

    // Haversine
    private double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371;
        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);

        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);

        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        return R * c;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
