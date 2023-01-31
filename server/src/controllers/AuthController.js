import User from "../models/User.js"
import jwt from 'jsonwebtoken'
import { handleErrors } from "../libs/utilities/handleErrors.js"

class AuthController {
    static #createToken(id) {
        return jwt.sign({ id }, process.env.SECRET, { expiresIn: '7d' });
    }

    static async register_user(req, res) {
        try {
            const user = await new User(req.body).save()
            const { password: userPassword, ...otherDetails } = user._doc
            res.status(200).json({ success: true, data: otherDetails })
            return
        } catch (error) {
            res.status(400).json({ success: false, errors: handleErrors(error) })
            return
        }
    }

    static async login_user(req, res) {
        const { email, password } = req.body

        try {
            const user = await User.login(email, password)
            const { password: userPassword, ...otherDetails } = user._doc

            // const token = this.#createToken(user._doc._id)
            // const opt = { httpOnly: true }

            // res.cookie('jwt', token, opt)
            res.status(200).json({ success: true, data: otherDetails })
            return
        } catch (error) {
            res.status(400).json({ success: false, errors: handleErrors(error) })
            return
        }
    }

    static async logout_user(req, res) {
        res.cookie('jwt', '', { maxAge: 1 })
        res.redirect('login')
    }
}

export default AuthController