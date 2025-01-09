const moment = require('moment'); // We'll use moment.js to handle dates easily.
const readline = require('readline');

// Order model to represent an order in the system
class Order {
    constructor(id, userId, orderTime, complexity, status) {
        this.id = id;
        this.userId = userId;
        this.orderTime = orderTime;
        this.eta = new Date();
        this.complexity = complexity; // A simple integer to represent the complexity of the order (1 - simple, 5 - complex)
        this.status = status; // Order status (e.g., placed, preparing, ready, completed)
    }
}

// Enum-like object to represent the order statuses
const OrderStatus = {
    PLACED: 'placed',
    PREPARING: 'preparing',
    READY: 'ready',
    COMPLETED: 'completed'
};

// Kitchen load model to represent the current load of the kitchen
class KitchenLoad {
    constructor(activeOrders, maxCapacity) {
        this.activeOrders = activeOrders;
        this.maxCapacity = maxCapacity;
    }

    // Simulate the kitchen load dynamically increasing or decreasing
    adjustLoad(change) {
        this.activeOrders += change;
        if (this.activeOrders < 0) this.activeOrders = 0; // Prevent negative orders
        if (this.activeOrders > this.maxCapacity) this.activeOrders = this.maxCapacity; // Prevent exceeding max capacity
    }
}

// Function to simulate ETA prediction based on user location and kitchen load
function predictETA(orderTime, kitchenLoad) {
    // Simulating a basic ETA prediction: more orders in the kitchen, longer the ETA.
    const baseETA = 15 * 60 * 1000; // Base ETA of 15 minutes (in milliseconds)
    const loadFactor = kitchenLoad.activeOrders / kitchenLoad.maxCapacity;
    const adjustedETA = baseETA * (1 + loadFactor);
    
    return new Date(orderTime.getTime() + adjustedETA);
}

// Function to prioritize orders based on ETA, kitchen load, and complexity
function prioritizeOrders(orders, kitchenLoad) {
    return orders.sort((order1, order2) => {
        // First, prioritize by ETA
        if (order1.eta.getTime() !== order2.eta.getTime()) {
            return order1.eta - order2.eta;
        }
        
        // If ETAs are the same, prioritize by order complexity
        return order1.complexity - order2.complexity;
    });
}

// Real-time synchronization mock function: Update order status in real-time
function updateOrderStatus(orderId, newStatus) {
    // In a real app, this would involve calling an API to update the order status on the server.
    // Simulating with a simple console.log for now.
    console.log(`Order ${orderId} status updated to ${newStatus}`);
}

// Simulate an order being placed
function placeOrder(orderId, userId, complexity, kitchenLoad) {
    const newOrder = new Order(orderId, userId, new Date(), complexity, OrderStatus.PLACED);
    newOrder.eta = predictETA(newOrder.orderTime, kitchenLoad);
    console.log(`New Order Placed: ID=${orderId}, User=${userId}, Complexity=${complexity}, ETA=${moment(newOrder.eta).format('YYYY-MM-DD HH:mm:ss')}`);
    
    return newOrder;
}

// Function to simulate processing and updating orders
async function processOrders() {
    const kitchenLoad = new KitchenLoad(10, 20); // Initialize with 10 active orders and max capacity 20
    
    let orders = []; // Array to store orders
    
    // Add a new order dynamically
    orders.push(placeOrder('1', 'user1', 3, kitchenLoad));
    orders.push(placeOrder('2', 'user2', 2, kitchenLoad));
    orders.push(placeOrder('3', 'user3', 5, kitchenLoad));

    // Simulate kitchen load changes (e.g., new orders being prepared)
    kitchenLoad.adjustLoad(1); // Kitchen load increases by 1 (e.g., a new order placed)
    kitchenLoad.adjustLoad(-2); // Kitchen load decreases by 2 (e.g., some orders completed)

    // Re-prioritize orders based on updated kitchen load
    orders = prioritizeOrders(orders, kitchenLoad);
    
    // Display orders after prioritization
    console.log('\nOrders after prioritization based on ETA and complexity:');
    orders.forEach(order => {
        console.log(`Order ${order.id} - ETA: ${moment(order.eta).format('YYYY-MM-DD HH:mm:ss')} - Complexity: ${order.complexity}`);
    });

    // Simulate real-time status updates
    updateOrderStatus("1", OrderStatus.PREPARING);
    updateOrderStatus("1", OrderStatus.READY);
    updateOrderStatus("2", OrderStatus.PREPARING);
    updateOrderStatus("2", OrderStatus.READY);
    
    // Simulate further dynamic changes (e.g., more orders added, or status updates)
    setTimeout(() => {
        orders.push(placeOrder('4', 'user4', 4, kitchenLoad)); // Place a new order after some time
    }, 5000); // Delay of 5 seconds

    // Example: Periodically adjust kitchen load and re-prioritize (Simulate a live system)
    setInterval(() => {
        kitchenLoad.adjustLoad(1); // Increment load periodically
        console.log(`\nKitchen load updated. Active orders: ${kitchenLoad.activeOrders}`);
        
        // Re-prioritize orders again after the kitchen load changes
        orders = prioritizeOrders(orders, kitchenLoad);
        console.log('\nRe-prioritized orders:');
        orders.forEach(order => {
            console.log(`Order ${order.id} - ETA: ${moment(order.eta).format('YYYY-MM-DD HH:mm:ss')} - Complexity: ${order.complexity}`);
        });
    }, 10000); // Every 10 seconds
}

// Run the main processing function
processOrders();
