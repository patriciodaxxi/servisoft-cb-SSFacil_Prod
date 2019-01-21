object DMConsLote: TDMConsLote
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 379
  Top = 84
  Height = 550
  Width = 801
  object qParametros: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT GERAR_TALAO_AUXILIAR, USA_LOTE'
      'FROM PARAMETROS')
    SQLConnection = dmDatabase.scoDados
    Left = 200
    Top = 56
    object qParametrosGERAR_TALAO_AUXILIAR: TStringField
      FieldName = 'GERAR_TALAO_AUXILIAR'
      FixedChar = True
      Size = 1
    end
    object qParametrosUSA_LOTE: TStringField
      FieldName = 'USA_LOTE'
      FixedChar = True
      Size = 1
    end
  end
  object qParametros_Lote: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT LOTE_TEXTIL'
      'FROM PARAMETROS_LOTE')
    SQLConnection = dmDatabase.scoDados
    Left = 200
    Top = 136
    object qParametros_LoteLOTE_TEXTIL: TStringField
      FieldName = 'LOTE_TEXTIL'
      FixedChar = True
      Size = 1
    end
  end
  object sdsMatLote: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT L.ID ID_LOTE, PMAT.id_material, PMAT.id_cor ID_COR_MAT,'#13#10 +
      'COMB.NOME NOME_COR_MAT, MAT.NOME NOME_MATERIAL, PMAT.qtd_consumo' +
      ' ,'#13#10'S.NOME NOME_SETOR, PMAT.ID_SETOR, MAT.ID_GRADE ID_GRADE_MAT,' +
      #13#10'PRO.ID_GRADE ID_GRADE_PROD, L.QTD'#13#10'FROM LOTE L'#13#10'INNER JOIN PRO' +
      'DUTO PRO'#13#10'ON L.ID_PRODUTO = PRO.ID'#13#10'INNER JOIN PRODUTO_COMB PC'#13#10 +
      'ON L.ID_PRODUTO = PC.ID'#13#10'AND L.id_combinacao = PC.id_cor_combina' +
      'cao'#13#10'INNER JOIN PRODUTO_COMB_MAT PMAT'#13#10'ON PC.ID = PMAT.ID'#13#10'AND P' +
      'C.item = PMAT.item'#13#10'INNER JOIN PRODUTO MAT'#13#10'ON PMAT.ID_MATERIAL ' +
      '= MAT.ID'#13#10'LEFT JOIN COMBINACAO COMB'#13#10'ON PMAT.ID_COR = COMB.ID'#13#10'L' +
      'EFT JOIN SETOR S'#13#10'ON PMAT.ID_SETOR = S.ID'#13#10
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 144
    Top = 352
  end
  object dspMatLote: TDataSetProvider
    DataSet = sdsMatLote
    Left = 184
    Top = 352
  end
  object cdsMatLote: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMatLote'
    Left = 232
    Top = 352
    object cdsMatLoteID_MATERIAL: TIntegerField
      FieldName = 'ID_MATERIAL'
    end
    object cdsMatLoteID_COR_MAT: TIntegerField
      FieldName = 'ID_COR_MAT'
    end
    object cdsMatLoteNOME_COR_MAT: TStringField
      FieldName = 'NOME_COR_MAT'
      Size = 60
    end
    object cdsMatLoteNOME_MATERIAL: TStringField
      FieldName = 'NOME_MATERIAL'
      Size = 100
    end
    object cdsMatLoteQTD_CONSUMO: TFloatField
      FieldName = 'QTD_CONSUMO'
    end
    object cdsMatLoteNOME_SETOR: TStringField
      FieldName = 'NOME_SETOR'
    end
    object cdsMatLoteID_SETOR: TIntegerField
      FieldName = 'ID_SETOR'
    end
    object cdsMatLoteID_LOTE: TIntegerField
      FieldName = 'ID_LOTE'
      Required = True
    end
    object cdsMatLoteID_GRADE_MAT: TIntegerField
      FieldName = 'ID_GRADE_MAT'
    end
    object cdsMatLoteID_GRADE_PROD: TIntegerField
      FieldName = 'ID_GRADE_PROD'
    end
    object cdsMatLoteQTD: TFloatField
      FieldName = 'QTD'
    end
  end
  object dsMatLote: TDataSource
    DataSet = cdsMatLote
    Left = 288
    Top = 352
  end
  object mMat: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    OnNewRecord = mMatNewRecord
    Left = 160
    Top = 296
    Data = {
      C00000009619E0BD010000001800000007000000000003000000C0000B49445F
      4D6174657269616C04000100000000000649445F436F7204000100000000000D
      4E6F6D655F4D6174657269616C01004900000001000557494454480200020064
      00084E6F6D655F436F720100490000000100055749445448020002003C000B51
      74645F436F6E73756D6F08000400000000000A4E6F6D655F5365746F72010049
      00000001000557494454480200020028000849445F5365746F72040001000000
      00000000}
    object mMatID_Material: TIntegerField
      FieldName = 'ID_Material'
    end
    object mMatID_Cor: TIntegerField
      FieldName = 'ID_Cor'
    end
    object mMatNome_Material: TStringField
      FieldName = 'Nome_Material'
      Size = 100
    end
    object mMatNome_Cor: TStringField
      FieldName = 'Nome_Cor'
      Size = 60
    end
    object mMatQtd_Consumo: TFloatField
      FieldName = 'Qtd_Consumo'
    end
    object mMatNome_Setor: TStringField
      FieldName = 'Nome_Setor'
      Size = 40
    end
    object mMatID_Setor: TIntegerField
      FieldName = 'ID_Setor'
    end
  end
  object dsmMat: TDataSource
    DataSet = mMat
    Left = 192
    Top = 296
  end
  object mMatGrade: TClientDataSet
    Active = True
    Aggregates = <>
    IndexFieldNames = 'ID_Setor;ID_Material;ID_Cor'
    MasterFields = 'ID_Setor;ID_Material;ID_Cor'
    MasterSource = dsmMat
    PacketRecords = 0
    Params = <>
    OnNewRecord = mMatGradeNewRecord
    Left = 272
    Top = 296
    Data = {
      7E0000009619E0BD0100000018000000050000000000030000007E000849445F
      5365746F7204000100000000000B49445F4D6174657269616C04000100000000
      000649445F436F7204000100000000000754616D616E686F0100490000000100
      055749445448020002000A000B5174645F436F6E73756D6F0800040000000000
      0000}
    object mMatGradeID_Setor: TIntegerField
      FieldName = 'ID_Setor'
    end
    object mMatGradeID_Material: TIntegerField
      FieldName = 'ID_Material'
    end
    object mMatGradeID_Cor: TIntegerField
      FieldName = 'ID_Cor'
    end
    object mMatGradeTamanho: TStringField
      FieldName = 'Tamanho'
      Size = 10
    end
    object mMatGradeQtd_Consumo: TFloatField
      FieldName = 'Qtd_Consumo'
    end
  end
  object dsmMatGrade: TDataSource
    DataSet = mMatGrade
    Left = 304
    Top = 296
  end
  object sdsTalao: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM TALAO'#13#10'WHERE ID = :ID'#13#10
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 144
    Top = 400
  end
  object dspTalao: TDataSetProvider
    DataSet = sdsTalao
    Left = 192
    Top = 400
  end
  object cdsTalao: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTalao'
    Left = 240
    Top = 400
    object cdsTalaoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsTalaoNUM_TALAO: TIntegerField
      FieldName = 'NUM_TALAO'
      Required = True
    end
    object cdsTalaoTAMANHO: TStringField
      FieldName = 'TAMANHO'
      Size = 10
    end
    object cdsTalaoQTD: TFloatField
      FieldName = 'QTD'
    end
  end
  object qParametros_Prod: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT USA_TAM_REFER_GRADE'
      'FROM PARAMETROS_PROD')
    SQLConnection = dmDatabase.scoDados
    Left = 304
    Top = 212
    object qParametros_ProdUSA_TAM_REFER_GRADE: TStringField
      FieldName = 'USA_TAM_REFER_GRADE'
      FixedChar = True
      Size = 1
    end
  end
  object frxReport1: TfrxReport
    Tag = 1
    Version = '5.6.8'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42032.577038136600000000
    ReportOptions.LastChange = 43485.488944282410000000
    ScriptLanguage = 'PascalScript'
    StoreInDFM = False
    OnReportPrint = 'frxReportOnReportPrint'
    Left = 560
    Top = 319
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 600
    Top = 319
  end
  object frxMailExport1: TfrxMailExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ShowExportDialog = True
    SmtpPort = 25
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    UseMAPI = SMTP
    MAPISendFlag = 0
    Left = 640
    Top = 319
  end
  object frxRichObject1: TfrxRichObject
    Left = 672
    Top = 319
  end
  object frxmMat: TfrxDBDataset
    UserName = 'frxmMat'
    OnFirst = frxmMatFirst
    OnNext = frxmMatNext
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_Material=ID_Material'
      'ID_Cor=ID_Cor'
      'Nome_Material=Nome_Material'
      'Nome_Cor=Nome_Cor'
      'Qtd_Consumo=Qtd_Consumo'
      'Nome_Setor=Nome_Setor'
      'ID_Setor=ID_Setor')
    OnOpen = frxmMatOpen
    DataSource = dsmMat
    BCDToCurrency = False
    Left = 560
    Top = 375
  end
  object frxmMatGrade: TfrxDBDataset
    UserName = 'frxmMatGrade'
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID_Setor=ID_Setor'
      'ID_Material=ID_Material'
      'ID_Cor=ID_Cor'
      'Tamanho=Tamanho'
      'Qtd_Consumo=Qtd_Consumo')
    DataSource = dsmMatGrade
    BCDToCurrency = False
    Left = 608
    Top = 375
  end
end
