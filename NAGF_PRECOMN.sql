CREATE OR REPLACE FUNCTION CONSINCO.NAGF_PRECOMN (psEAN        IN NUMBER,
                                                  psNroEmpresa IN CONSINCO.MAX_EMPRESA.NROEMPRESA%TYPE) 
  RETURN NUMBER IS
  vPreco CONSINCO.MRL_PRODEMPSEG.PRECOVALIDNORMAL%TYPE;
  
BEGIN
  BEGIN
    
SELECT /*+OPTIMIZER_FEATURES_ENABLE('11.2.0.4')*/ MIN(PRECOPPROMOCIONAL)
  INTO vPreco
  FROM REMARCAPROMOCOES@INFOPROCMSSQL X
 WHERE CODLOJA = psNroEmpresa
   AND CODIGOPRODUTO = LPAD(psEAN,14,0)
   AND SYSDATE BETWEEN DTINICIO AND DTFIM
   AND X.TIPODESCONTO  = 4
   AND X.PROMOCAOLIVRE = 0;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      vPreco := 0;
  END;

  RETURN vPreco;
END;
