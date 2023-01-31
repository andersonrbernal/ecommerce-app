import Purchase from "../models/Purchase.js"
import User from '../models/User.js'

class PurchaseController {
    static async register_purchase(req, res) {
        const { id } = req.params

        try {
            const user = await User.findById(id)
            const cartIsEmpty = !user.cart.length > 0

            if (cartIsEmpty) {
                res.status(400).json({ success: false, errors: { data: 'Empty cart.' } })
                return
            }

            const purchase = new Purchase({ userId: user._id, cart: user.cart })
            await purchase.save()

            const savedPurchase = await Purchase.findById(purchase._id)

            res.status(200).json({ success: true, data: savedPurchase })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }
}

export default PurchaseController