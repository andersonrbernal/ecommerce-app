class ProductController {
    static async get_products_that_are_not_in_cart(req, res) {
        const { id: uid } = req.params

        try {
            const response = await fetch(process.env.PROVIDER_API)
            const products = await response.json()
            const cartResponse = await fetch('http://localhost:3000/cart/' + uid)
            const cartProducts = await cartResponse.json();
            let finalProducts = [];

            products.forEach(product => {
                cartProducts.data.cart.includes(parseInt(product.id)) ? null : finalProducts.push(product)
            });

            res.status(200).json({ success: true, data: finalProducts })
            return
        } catch (error) {
            res.status(500).json({ success: false, errors: { data: error.message } })
            return
        }
    }
}

export default ProductController