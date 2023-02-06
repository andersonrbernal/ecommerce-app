import mongoose, { Schema } from "mongoose";
import fetch from 'node-fetch'

async function triggerPurchaseAfter(_doc, next) {
    try {
        const response = await fetch(process.env.PROVIDER_API)
        const products = await response.json()
        const purchase = await Purchase.findById(_doc._id)
        let cartProducts = []
        let total = 0.00

        // finds the details of every product that exists in the user cart
        products.forEach(product => {
            purchase.cart.includes(product.id) ? cartProducts.push(product) : null
        })

        // calculates the total value of the purchase
        cartProducts.forEach(product => {
            total += parseFloat(product.preco)
        })

        await Purchase.findByIdAndUpdate(purchase._id, { total: total })
    } catch (error) {
        throw Error(error)
    }
    next()
}

function calcTotal() {
    console.log('dsafsadfds')
}

const purchaseStructure = {
    userId: {
        type: Schema.Types.ObjectId,
        required: true,
    },
    cart: {
        type: Array,
        required: true
    },
    total: {
        type: Number,
    }
}

const purchaseSchema = new Schema(purchaseStructure, { timestamps: true })
purchaseSchema.static.calcTotal = calcTotal

purchaseSchema.post('save', triggerPurchaseAfter)

const Purchase = mongoose.model('Purchase', purchaseSchema)

export default Purchase
