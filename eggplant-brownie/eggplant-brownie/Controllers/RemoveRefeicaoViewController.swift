//
//  RemoveRefeicaoViewController.swift
//  eggplant-brownie
//
//  Created by Lucivaldo Queiroz on 12/07/22.
//

import Foundation
import UIKit

class RemoveRefeicaoViewController{
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    
    func exibe( refeicao: Refeicao, handler: @escaping (UIAlertAction) -> Void) {
        let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
        let botaoCancelar = UIAlertAction(title: "ok", style: .cancel)
        alerta.addAction(botaoCancelar)
        let botaoRemover = UIAlertAction(title: "remover", style: .destructive, handler: handler)
        alerta.addAction(botaoRemover)
        
        controller.present(alerta, animated: true, completion: nil)
    }
    
}
