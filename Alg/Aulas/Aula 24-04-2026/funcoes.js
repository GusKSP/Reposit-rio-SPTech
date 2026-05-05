
function calcular_media(valor) {
    let soma = 0
    for (let i = 0; i < valor.length; i++) {
        soma += valor[i]
    }
    console.log(soma)
    let media = soma / valor.length;
    Resultado.innerHTML = `A média eh ${media}`
}