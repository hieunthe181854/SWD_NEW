/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *hieunthe181854
 */
public class Booking {
    private int customerID;
    private String pickupAddress;
    private String destinationAddress;
    private double pickupLat;
    private double pickupLng;
    private double destLat;
    private double destLng;
    private double estimatedPrice;

    public Booking() {
    }

    public Booking(int customerID, String pickupAddress, String destinationAddress, double pickupLat, double pickupLng, double destLat, double destLng, double estimatedPrice) {
        this.customerID = customerID;
        this.pickupAddress = pickupAddress;
        this.destinationAddress = destinationAddress;
        this.pickupLat = pickupLat;
        this.pickupLng = pickupLng;
        this.destLat = destLat;
        this.destLng = destLng;
        this.estimatedPrice = estimatedPrice;
    }

    public int getCustomerID() {
        return customerID;
    }

    public String getPickupAddress() {
        return pickupAddress;
    }

    public String getDestinationAddress() {
        return destinationAddress;
    }

    public double getPickupLat() {
        return pickupLat;
    }

    public double getPickupLng() {
        return pickupLng;
    }

    public double getDestLat() {
        return destLat;
    }

    public double getDestLng() {
        return destLng;
    }

    public double getEstimatedPrice() {
        return estimatedPrice;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public void setPickupAddress(String pickupAddress) {
        this.pickupAddress = pickupAddress;
    }

    public void setDestinationAddress(String destinationAddress) {
        this.destinationAddress = destinationAddress;
    }

    public void setPickupLat(double pickupLat) {
        this.pickupLat = pickupLat;
    }

    public void setPickupLng(double pickupLng) {
        this.pickupLng = pickupLng;
    }

    public void setDestLat(double destLat) {
        this.destLat = destLat;
    }

    public void setDestLng(double destLng) {
        this.destLng = destLng;
    }

    public void setEstimatedPrice(double estimatedPrice) {
        this.estimatedPrice = estimatedPrice;
    }
    
}
