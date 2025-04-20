//import { Product } from 'generated/prisma';
//export type CreateProductDto = Omit<Product, 'id' | 'createdAt' | 'updatedAt'>
import {
    IsString,
    IsNotEmpty,
    IsOptional,
    IsNumber,
    IsPositive
} from 'class-validator';



export class CreateProductDto {

    @IsNotEmpty()
    @IsString()
    name: string;

    @IsOptional()
    description?: string;

    @IsOptional()
    type?: string;

    @IsNotEmpty()
    @IsNumber()
    @IsPositive()
    price: number;

    @IsNotEmpty()
    @IsNumber()
    stock: number;


    @IsOptional()
    @IsString()
    image?: string;
}
