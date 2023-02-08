import { Router } from "express";
import ProductController from "../controllers/ProductController.js";

const router = Router()

router.get('/:id', ProductController.get_products_that_are_not_in_cart)

export default router