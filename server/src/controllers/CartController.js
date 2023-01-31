import User from "../models/User.js"

class CartController {
    static async get_cart(req, res) {
        const { id } = req.params

        try {
            const cart = await User.findOne({ _id: id }, { cart: 1 })
            return res.status(200).json({ success: true, data: cart })
        } catch (error) {
            return res.status(500).json({ success: false, errors: { data: error.message } })
        }
    }

    static async update_cart(req, res) {
        const { id } = req.params
        const { productId } = req.body

        try {
            let user = await User.findById(id)
            const cartDoesntIncludeProductId = !user.cart.includes(productId)

            if (cartDoesntIncludeProductId) {
                await user.updateOne({ $push: { cart: productId } })
            } else {
                await user.updateOne({ $pull: { cart: productId } })
            }

            user = await User.findById(id) // finds user again to get updated cart
            res.status(200).json({ success: true, data: user.cart })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }

    static async delete_cart(req, res) {
        const { id } = req.params

        try {
            const user = await User.findById(id).updateOne({ cart: [] })
            res.status(200).json({ success: true, data: user })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }
}

export default CartController