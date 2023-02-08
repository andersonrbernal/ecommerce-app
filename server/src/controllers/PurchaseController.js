import Purchase from "../models/Purchase.js"
import User from '../models/User.js'

class PurchaseController {
    static async get_user_purchases(req, res) {
        const { id } = req.params

        try {
            const user = await User.findById(id)

            if (!user) {
                res.status(400).json({ success: false, message: 'User not found.' })
                return
            }

            const purchases = await Purchase.find({ userId: user._id })

            if (!purchases) {
                res.status(400).json({ success: false, message: 'That user has no purchases.' })
                return
            }

            res.status(200).json({ success: true, data: purchases })
            return

        } catch (error) {
            res.status(500).json({ success: false, message: error.message })
            return
        }
    }

    static async register_purchase(req, res) {
        const { id } = req.params

        try {
            const user = await User.findById(id)

            if (!user) {
                res.status(400).json({ success: false, message: 'User not found.' })
            }

            const cartIsEmpty = !user.cart.length > 0

            if (cartIsEmpty) {
                res.status(400).json({ success: false, message: 'Empty cart.' })
                return
            }

            const purchase = new Purchase({ userId: user._id, cart: user.cart })
            await purchase.save()
            await User.findByIdAndUpdate(user._id, { $unset: { cart: [] } })

            console.log(await User.findById(user._id))

            const savedPurchase = await Purchase.findById(purchase._id)

            res.status(200).json({ success: true, data: savedPurchase })
            return
        } catch (error) {
            res.status(500).json({ success: false, message: error.message })
            return
        }
    }
}

export default PurchaseController