using Test,HTTP,CSV, Tables, Plots, XLSX




guest_list = XLSX.readxlsx("RSVP (Responses).xlsx")["Form responses 1"]

first_name = guest_list["B5:B200"][ismissing.(guest_list["B5:B200"]) .== 0] .|> String
last_name = guest_list["H5:H200"][ismissing.(guest_list["H5:H200"]) .== 0] .|> String
name_res = first_name .* " " .* last_name
res = guest_list["C5:C200"][ismissing.(guest_list["C5:C200"]) .== 0] .|> String
total_people = length(first_name)



full_list = XLSX.readxlsx("guestListClean.xlsx")["Sheet1"]
first_name_full = full_list["A2:A200"][ismissing.(full_list["A2:A200"]) .== 0] .|> String
last_name_full = full_list["B2:B200"][ismissing.(full_list["B2:B200"]) .== 0] .|> String
full_list_len = length(first_name_full)


using DataFrames
df = DataFrame(
    name = first_name_full .* " " .* last_name_full,
    response = "No Response"
)



for j ∈ 1:total_people
    found = false
    for i ∈ 1:full_list_len
        if df.name[i] == name_res[j]
            found = true
            df.response[i] = res[j]
        end
    end
    if !found
        println(name_res[j])
    end
end

XLSX.writetable("compiled.xlsx", df)



j = 1


no_match ∩ Set{String}(name_res[j])




Pkg.add("GoogleSheets")
Pkg.build("GoogleSheets")








df




using GoogleSheets

# Example based upon: # https://developers.google.com/sheets/api/quickstart/python

client = sheets_client(AUTH_SCOPE_READONLY)

# The ID and range of a sample spreadsheet.
SAMPLE_SPREADSHEET_ID = "1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms"
SAMPLE_RANGE_NAME = "Class Data!A2:E"

sheet = Spreadsheet(SAMPLE_SPREADSHEET_ID)
range = CellRange(sheet, SAMPLE_RANGE_NAME)