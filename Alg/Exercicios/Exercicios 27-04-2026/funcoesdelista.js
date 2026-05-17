function adicionarNoFinal(lista, elemento) {
    let novaLista = [];
    for (let i = 0; i <= lista.length; i++) {
        if (i < lista.length) {
            novaLista[i] = lista[i];
        } else {
            novaLista[i] = elemento;
        }
    }
    return novaLista;
}
function removerDoFinal(lista) {
    let novaLista = [];
    for (let i = 0; i < lista.length - 1; i++) {
        novaLista[i] = lista[i];
    }
    return novaLista;
}

function removerDoInicio(lista) {
    let novaLista = [];
    for (let i = 1; i < lista.length; i++) {
        novaLista[i - 1] = lista[i];
    }
    return novaLista;
}

function adicionarNoInicio(lista, elemento) {
    let novaLista = [];
    for (let i = 0; i <= lista.length; i++) {
        if (i === 0) {
            novaLista[i] = elemento;
        } else {
            novaLista[i] = lista[i - 1];
        }
    }
    return novaLista;
}

alterarLista = (lista, indice, quantidade, novoElemento) => {
    let novaLista = [];
    for (let i = 0; i < lista.length; i++) {
        if (i < indice) {
            novaLista[i] = lista[i]
        }
        else if (i >= indice && i < indice + quantidade && novoElemento === "") {
        }
        else if (i >= indice && i < indice + quantidade && novoElemento !== "") {
            novaLista[i] = novoElemento;
        }
        else {
            novaLista[i] = lista[i];
        }
    }
    return novaLista;
}