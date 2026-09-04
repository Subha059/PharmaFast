package model;

import java.sql.Date;

public class Order {

    private int id;
    private int patientId;
    private int medicineId;
    private int quantity;
    private double totalPrice;
    private Date orderDate;

    // No-argument constructor
    public Order() {
    }

    // Parameterized constructor
    public Order(int id, int patientId, int medicineId, int quantity,
                 double totalPrice, Date orderDate) {
        this.id = id;
        this.patientId = patientId;
        this.medicineId = medicineId;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getMedicineId() {
        return medicineId;
    }

    public void setMedicineId(int medicineId) {
        this.medicineId = medicineId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
}
