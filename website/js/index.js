import approved from './approved.json';

function checkIfAppr(email) {
    for (let i = 0; i < approved.length; i++) {
        if (approved[i].email === email) {
            return true;
        }
    }

    return false;
}
