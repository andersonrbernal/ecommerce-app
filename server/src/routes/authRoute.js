import { Router } from "express";
import AuthController from "../controllers/AuthController.js";

const router = Router()

router.post('/register', AuthController.register_user)
router.post('/login', AuthController.login_user)

export default router 