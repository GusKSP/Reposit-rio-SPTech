function Somar(numero1, numero2) {
    let Resultado = ""

    if (Numero1 == null || Numero1 == undefined) {
        console.log("Numero1 não pode ser nulo!")
    }
    if (Numero2 == null || Numero2 == undefined) {
        console.log("Numero2 não pode ser nulo!")
    }
    if ((Numero1 != null || Numero1 != undefined) && (Numero2 != null || Numero2 != undefined)) {
        let soma = Number(Numero1) + Number(Numero2)
        console.log(soma)
    }
}