import { Router } from "express";
import CartController from "../controllers/CartController.js";

const router = Router()

router.get('/:id', CartController.get_cart)
router.get('/products/:id', CartController.get_cart_products)
router.put('/:id', CartController.update_cart)
router.delete('/:id', CartController.delete_cart)

export default router