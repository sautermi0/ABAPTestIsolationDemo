# ABAP Test Isolation Frameworks
This repository contains examples for all currently available test isolation tools in the ABAP Platform. 

## The Idea
The idea of this repository is to show how to use any test environment, helper class and some common design patterns that help with isolating your code under test from its depended-on components.

## How To Use This Repository
If you want to isolate your code under test from the components it uses, you need to take a look at what your depended-on component is. Each isolation technique for a specific kind of depended-on component is used separate test class of the global class ZATI_CL_CODE_UNDER_TEST. 
The table below shows which test class uses which tool to isolate against which kind of depended-on component.

Test Class | Depended-On Component | Tool | 
----- | ----- | ------
ltc_call_other_object | Classes | Self-made test doubles 
ltc_call_other_object_fw | Classes | [ABAP Object Oriented Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM/c238d694b825421f940829321ffa326a/804c251e9c19426cadd1395978d3f17b.html?locale=en-US)
ltc_call_function_module | Function Modules | [Function Module Test Double Framework](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/75964f284aa9435da40c4d82e111f276.html?locale=en-US)
ltc_select_database_table | Database Tables and CDS Entities | [ABAP SQL Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM/c238d694b825421f940829321ffa326a/1432ca1fc7b547d493f691cdd09245ae.html?locale=en-US)
ltc_select_cds_entity | Database Artefacts which are used in CDS | [ABAP CDS Test Double Framework](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/cbedc08ff4de48ffa8d04d3067ef08e7.html?locale=en-US)
ltc_call_authority_check | Authority Checks | [Classic ABAP Authority Check Test Helper API](https://help.sap.com/docs/ABAP_PLATFORM_NEW/c238d694b825421f940829321ffa326a/6500d4d8f89a4743a6c0513d659a475b.html?locale=en-US)
ltcl_call_rap_bo_tx_bf_dbl | RAP Business Objects | [Transactional Buffer Double Support](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/0337944d45994a3ba7482421cdfe36c8.html)
ltcl_call_rap_bo_mock_eml_api | RAP Business Objects | [Mock EML API Support](https://help.sap.com/docs/SAP_S4HANA_CLOUD/25cf71e63940453397a32dc2b7676947/4fa0e8a6ea0d4c45bec1afdc1ac6bd49.html?locale=en-US)

## Disclaimer
All of the contents of this repository and the knowledge used to implement the examples are publicly available. My contributions to this repository are private and not on behalf of SAP.
