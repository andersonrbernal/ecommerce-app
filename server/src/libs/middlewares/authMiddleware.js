import jwt from 'jsonwebtoken'
import User from '../../models/User.js';

function requireAuth(req, res, next) {
    /**
     * Verifies if authentication token is valid.
     * @param {Request} req HTTP Request
     * @param {Response} req HTTP Response
     * @param {Function} next Function to carry on the rest of the request path
     * @return {void} No return
     */
    const token = req.cookies.jwt;

    if (token) {
        jwt.verify(token, process.env.SECRET, (err, decodedToken) => {
            if (err) {
                console.log(err.message);
                res.redirect('login');
                return
            }
            next();
        });
    }
    res.redirect('login');
    return
}

async function checkUser(req, res, next) {
    /**
     * Verifies if user exists in local storage.
     * @param {Request} req HTTP Request
     * @param {Response} req HTTP Response
     * @param {Function} next Function to carry on the rest of the request path
     * @return {void} No return
     */

    const token = req.cookies.jwt;

    if (token) {
        jwt.verify(token, process.env.SECRET, async (err, decodedToken) => {
            if (err) {
                console.log(err.message);
                res.locals.user = null;
                next();
                return
            }

            let user = await User.findById(decodedToken.id);
            res.locals.user = user;
            next();
            return
        });
    }
    res.locals.user = null;
    next();
    return
}

export { requireAuth, checkUser }