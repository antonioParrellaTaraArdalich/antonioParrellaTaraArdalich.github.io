using XLSX

guest_list = XLSX.readxlsx("guestListClean.xlsx")["Sheet1"][:][2:end,3]
links = XLSX.readxlsx("guestListClean.xlsx")["Sheet1"][:][2:end,5]
total_people = length(guest_list)
names_clean = guest_list .|> String 



function table_row(name::String, link::String)
    row = "<tr>\n   <td><a href = " * link * ">" * name * "</a></td>\n</tr>\n"
end








open("table_code.txt", "w") do f
    for i ∈ 1:total_people
        row = table_row(names_clean[i], links[i])
        write(f, row)
    end
end