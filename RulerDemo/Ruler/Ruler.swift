//
//  Ruler.swift
//  RulerDemo
//
//  Created by Rey on 2018/8/10.
//  Copyright © 2018 Rey. All rights reserved.
//

import UIKit

//创建 ScreenModel 枚举类型，针对传统屏幕又添加了两个屏幕尺寸的枚举 iPad 分了两个枚举
public enum ScreenModel {
    
    public enum ClassicModel {
        case inch35
        case inch4
    }
    case classic(ClassicModel)
    case bigger
    case biggerPlus
    case x
    
    public enum PadModel {
        case normal
        case pro
    }
    
    case iPad(PadModel)
}



/// 获取屏幕模型枚举
private let screenModel: ScreenModel = {
    
    let screen = UIScreen.main
    let height = max(screen.bounds.width, screen.bounds.height)
    switch height {
    case 480:
        return .classic(.inch35)
    case 568:
        return .classic(.inch4)
    case 667:
        return .bigger
    case 736, 1920:
        return .biggerPlus
    case 812:
        return .x
    case 1024:
        return .iPad(.normal)
    case 1112, 1366:
        return .iPad(.pro)
    default:
        print("Warning: Can NOT detect screenModel! bounds: \(screen.bounds) nativeScalse: \(screen.nativeScale)")
        return .bigger // Default
    }
}()


public enum Ruler<T> {
    
    case iPhoneHorizontal(T,T,T)
    case iPhoneVertical(T,T,T,T,T)
    case iPad(T,T)
    case universalHorizontal(T,T,T,T,T)
    case universalVertical(T,T,T,T,T,T,T)
    
    public var value: T {
        switch self {
        case let .iPhoneHorizontal(classic, bigger, biggerPlus):
            switch screenModel {
            case .classic:
                return classic
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return bigger
            default:
                return biggerPlus
            }
        case let .iPhoneVertical(inch35, inch4, bigger, biggerPlus, x):
            switch screenModel {
            case .classic(let model):
                switch model {
                case .inch35:
                    return inch35
                case .inch4:
                    return  inch4
                }
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return x
            default:
                return biggerPlus
            }
            
        case let .iPad(normal, pro):
            switch screenModel {
            case .iPad(let model):
                switch model {
                case .normal:
                    return normal
                case .pro:
                    return pro
                }
            default:
                return normal
            }
        case let .universalHorizontal(classic, bigger, biggerPlus, iPadNormal, iPadPro):
            switch screenModel {
            case .classic:
                return classic
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return bigger
            case .iPad(let model):
                switch model {
                case .normal:
                    return iPadNormal
                case .pro:
                    return iPadPro
                }
            }
            
        case let .universalVertical(inch35, inch4, bigger, biggerPlus, x, iPadNormal, iPadPro):
            switch screenModel {
            case .classic(let model):
                switch model {
                case .inch35:
                    return inch35
                case .inch4:
                    return inch4
                }
                
            case .bigger:
                return bigger
            case .biggerPlus:
                return biggerPlus
            case .x:
                return x
            case .iPad(let model):
                switch model {
                case .normal:
                    return iPadNormal
                case .pro:
                    return iPadPro
                }
            }
        }
    }
}

extension ScreenModel {
    public static var isPhoneX: Bool {
        switch screenModel {
        case .x:
            return true
        default:
            return false
        }
    }
}
