import { Router } from "express";
import PurchaseController from "../controllers/PurchaseController.js";

const router = Router()

router.post('/register/:id', PurchaseController.register_purchase)

export default router 