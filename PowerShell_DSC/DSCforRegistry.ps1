configuration DSConfigTo2PC
{
    Node @('WorkStation1', 'SCCMServer')
    {
        Registry RegistryExamle1
            {
            Ensure = "Present"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey1"
            ValueName = "TestValue1"
            ValueData = "TestData1"
            }
         Registry RegistryExamle2
            {
            Ensure = "Absent"
            Key = "HKEY_LOCAL_MACHINE\SOFTWARE\ExampleKey2"
            ValueName = "TestValue3"
            ValueData = "TestData3"
            }


     }
}

DSConfigTo2PC