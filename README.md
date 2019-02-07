DataStructures and Storage Patterns in Solidity

## Serialization and Deserialization:

- https://github.com/kanthgithub/Seriality

  - Seriality is a library for serializing and de-serializing all the Solidity types in a very efficient way which mostly written in solidity-assembly.

- https://ethereum.stackexchange.com/questions/11246/convert-struct-to-bytes-in-solidity

  - Is there any convenient way to convert (e.g. cast) a struct type to bytes?

   - You can do something like this. Note, for every custom struct you'll have to write custom serialization and deserialization methods.

    ```js
    pragma solidity ^0.4.0;

    contract StructSerialization
    {
        function StructSerialization()
        {
        }

        event exactUserStructEvent(uint32 id, string name);

        //Use only fixed size simple (uint,int) types!
        struct ExactUserStruct
        {
            uint32 id;
            string name;
        }

        function showStruct(ExactUserStruct u) private
        {
            exactUserStructEvent(u.id, u.name);
        }


        function exactUserStructToBytes(ExactUserStruct u) private
        returns (bytes data)
        {
            // _size = "sizeof" u.id + "sizeof" u.name
            uint _size = 4 + bytes(u.name).length;
            bytes memory _data = new bytes(_size);

            uint counter=0;
            for (uint i=0;i<4;i++)
            {
                _data[counter]=byte(u.id>>(8*i)&uint32(255));
                counter++;
            }

            for (i=0;i<bytes(u.name).length;i++)
            {
                _data[counter]=bytes(u.name)[i];
                counter++;
            }

            return (_data);
        }


        function exactUserStructFromBytes(bytes data) private
        returns (ExactUserStruct u)
        {
            for (uint i=0;i<4;i++)
            {
                uint32 temp = uint32(data[i]);
                temp<<=8*i;
                u.id^=temp;
            }

            bytes memory str = new bytes(data.length-4);

            for (i=0;i<data.length-4;i++)
            {
                str[i]=data[i+4];
            }

            u.name=string(str);
         }

        function test()
        {
            //Create and  show struct
            ExactUserStruct memory struct_1=ExactUserStruct(1234567,"abcdef");
            showStruct(struct_1);

            //Serializing struct
            bytes memory serialized_struct_1 = exactUserStructToBytes(struct_1);

            //Deserializing struct
            ExactUserStruct memory struct_2 = exactUserStructFromBytes(serialized_struct_1);

            //Show deserealized struct
            showStruct(struct_2);
        }
    }
    ```

### Structs:

- Solidity tutorial: returning structs from public functions

  - https://medium.com/coinmonks/solidity-tutorial-returning-structs-from-public-functions-e78e48efb378
  
   - Return Struct and Array of Structs in solidity
