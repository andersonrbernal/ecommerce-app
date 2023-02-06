import User from "../models/User.js"

class CartController {
    static async get_cart(req, res) {
        const { id: uid } = req.params

        try {
            const cart = await User.findOne({ _id: uid }, { cart: 1 })
            res.status(200).json({ success: true, data: cart })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }

    static async get_cart_products(req, res) {
        const { id: uid } = req.params

        try {
            const providerResponse = await fetch(process.env.PROVIDER_API)
            const providerProducts = await providerResponse.json()
            const cartResponse = await fetch('http://localhost:3000/cart/' + uid)
            const cartProducts = await cartResponse.json();
            let cartProductDetails = []

            providerProducts.forEach((product) => {
                cartProducts.data.cart.includes(parseInt(product.id)) ? cartProductDetails.push(product) : null
            });

            res.status(200).json({ success: true, data: cartProductDetails })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }

    static async update_cart(req, res) {
        const { id: uid } = req.params
        const { productId } = req.body

        try {
            let user = await User.findById(uid)
            const cartDoesntIncludeProductId = !user.cart.includes(productId)

            if (cartDoesntIncludeProductId) {
                await user.updateOne({ $push: { cart: productId } })
            } else {
                await user.updateOne({ $pull: { cart: productId } })
            }

            user = await User.findById(uid) // finds user again to get updated cart
            res.status(200).json({ success: true, data: user.cart })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }

    static async delete_cart(req, res) {
        const { id: uid } = req.params

        try {
            const user = await User.findById(uid).updateOne({ cart: [] })
            res.status(200).json({ success: true, data: user })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }
}

export default CartController