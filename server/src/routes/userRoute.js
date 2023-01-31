import { Router } from "express";
import UserController from "../controllers/userController.js";

const router = Router()

router.get('/:id', UserController.get_user)

export default router 